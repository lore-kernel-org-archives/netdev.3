Received: from mta0.migadu.com (out-50.mta0.migadu.com [91.218.175.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792103655FA
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786746962; cv=none; b=ab9tIrboeSxdpv68RrWN2iYaOGc/aNCR+xPUGXjJiWji+1hBjFXHTpPx56OhSROHR2S2WBQEsZrN5uZ7zjixHmQ/BU17+8LZ1r4iCZ+Ni/+ciQcMGi5hqLfslnoS5NEE36TWw0bLpgqr7sZk9ogoILvFrom10Q4+SYSPQQTsvOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786746962; c=relaxed/simple;
	bh=j2vVLjujy7J9hnG+a/goyUa1CpfWLRBE4wlmyu83kyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8E4e7Rv7f+frB3xnQd06fD/IMEvsOTob5W0Cn8uQnuEler4AbQl1kEhNc1iMVT//GnwQ66ojispOSbGnAyDv7X0oiRfc191agoOCqZiy+Pduzx8pbIyuJ5iPSCYbl+64kqCEBEaC6NmsD9xheuQ+DLFVnubHBIZBPJi4y2PcG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X/wRroek; arc=none smtp.client-ip=91.218.175.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X/wRroek"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=j2vVLjujy7J9hnG+a/goyUa1CpfWLRBE4wlmyu83kyE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786746958; v=1; x=1787351758;
 b=X/wRroekMAtHeYIa2hYbdhfd02Tqc3sJ4PzIFO00GuXszbd9KmPbx91/7lIqTKyXWR8bn08P
 sP2w+nZZzioXgTunusjbACS6gwBw7r6e8d4KlGohHcfR0/s7EHrczfjujWmtvBDPGvWH9enCJ/L
 c/SatSxSMFpRfbRMf9Xi/KPY=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.1.24] (109.76.33.138)
	by smtp.migadu.com with ESMTPS id b78091e580d1a043;
	Fri, 14 Aug 2026 22:35:58 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <e28dd09f-be7b-4f74-9d42-95baca307db0@linux.dev>
Date: Fri, 14 Aug 2026 23:35:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] dpll: fix NULL deref in dpll_device_ops() during
 teardown race
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Michal Michalik <michal.michalik@intel.com>,
 Milena Olech <milena.olech@intel.com>, linux-kernel@vger.kernel.org,
 ivecera@redhat.com
References: <20260813140817.1051388-1-poros@redhat.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260813140817.1051388-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2026 15:08, Petr Oros wrote:
> When the last owner of a dpll device unregisters while a foreign driver
> still holds a pin on it via dpll_pin_on_pin_register(), the dpll object
> stays alive with an empty registration list. A pin notification queued
> before the unregister (e.g. ice reacting to zl3073x_i2c removal) then
> walks pin->dpll_refs into dpll_device_ops(), which trips the WARN_ON and
> dereferences the missing registration. dpll_lock cannot help because the
> notification work was queued before the unregistering driver took the
> lock.
> 
> Treat the empty registration list as a legitimate transient state. Make
> dpll_priv() and dpll_device_ops() return NULL in that case and make
> every pin netlink path that resolves a device from a pin skip such
> dplls. dpll_cmd_pin_get_one() picks a ref with a live registration and
> returns -ENODEV when there is none, the pin dumpit skips such a pin
> instead of aborting the dump, dpll_msg_add_pin_dplls() and the
> frequency, esync, reference sync and phase adjust set paths skip dead
> refs, and dpll_pin_parent_device_set() validates the parent with
> dpll_device_get_by_id(). dpll_pin_register() is the last caller that
> dereferenced the device ops without a check, so move its frequency
> monitor validation under dpll_lock and tolerate a missing registration
> there as well.
> 
> The empty registration list is equivalent to a cleared DPLL_REGISTERED
> mark, both transitions happen under dpll_lock in dpll_device_register()
> and dpll_device_unregister(). A pin notification for a pin whose dplls
> are all gone is now dropped with -ENODEV instead of crashing, all
> callers in the core ignore that return value.
> 
>   WARNING: drivers/dpll/dpll_core.c:1092 at dpll_device_ops+0x24/0x40,
>   CPU#83: kworker/u576:3/23471
>   Modules linked in: ... ice ... zl3073x_i2c(-) ... zl3073x ...
>   Workqueue: ice_dpll_wq ice_dpll_pin_notify_work [ice]
>   RIP: 0010:dpll_device_ops+0x24/0x40
>   Call Trace:
>    <TASK>
>    dpll_cmd_pin_get_one+0x336/0x520
>    dpll_pin_event_send+0x82/0x140
>    dpll_pin_on_pin_unregister+0xbb/0x160
>    ice_dpll_pin_notify_work+0x1bc/0x1f0 [ice]
>    process_one_work+0x19e/0x370
>    worker_thread+0x1a6/0x310
>    kthread+0xe4/0x120
>    ret_from_fork+0x1a1/0x270
>    ret_from_fork_asm+0x1a/0x30
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
>   BUG: kernel NULL pointer dereference, address: 0000000000000010
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
> 
> Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
> v2:
> - guard every path that resolves a device from a pin, not only the
>    first ref in dpll_cmd_pin_get_one(); skip half-dead refs in
>    dpll_msg_add_pin_dplls() and the set paths, select a live
>    representative ref and turn the pin dumpit -ENODEV into a per pin
>    skip (Jakub)
> - validate the parent device in dpll_pin_parent_device_set() via
>    dpll_device_get_by_id()
> - guard the frequency monitor validation in dpll_pin_register() and
>    perform it under dpll_lock, it was the only remaining unchecked
>    dereference of the device ops
> - drop patch 2/2, superseded by commit 32239d600236 ("dpll: fix stale
>    iteration in dpll_pin_on_pin_unregister()")
> 
> v1: https://lore.kernel.org/all/20260516191317.1005612-2-poros@redhat.com/
> ---
>   drivers/dpll/dpll_core.c    | 24 +++++++++------
>   drivers/dpll/dpll_netlink.c | 59 ++++++++++++++++++++++++++++++++-----
>   2 files changed, 67 insertions(+), 16 deletions(-)
> 

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
