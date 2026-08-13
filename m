Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1910548A8C8
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635475; cv=none; b=tjWr9sscTcUzTyUmNP2b1aXzfCHIfM2Ke4QOrKaHhvhUOHtvLcj1DCo9tVnaLJGKjo5HWrTY1lPEO9Bpjq4W57WRmzzK/l5lvosAPeBeDySD2oJfMbAmMCsS4kPmXGdu/t/uy/VJ7emZCsrp+VM2pSQcuKMrlKFm7hHeEUTGN7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635475; c=relaxed/simple;
	bh=Pcim93r8p9BWUMTNU5sRku0JTo0EJxl3tCFdWf72RAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVoNQs6XdWlSE4pqbQqzkTrwgHJL1kRwmNWHKyGqHtzrx1kxJRyGb54SnHek+khyby0F7tPX1H2MWAtu+QRkz9W64ltl4oIwYPEdR5v6KPrBfUcr9uACWOgjeTAsaToNHp9QNk4VzXftd8mdZZC8krn//jvgwIlR/S2QqoIEhJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EUH7UBMo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUH7UBMo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786635457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdTNXPX7SsRWxcVYsxUY+cluxc5Mdj/SmHqdDXqVqeA=;
	b=EUH7UBMohRgiiSZUcKYR7d2W1ljRQE00Opy0rTqUnt/m7aK+ZNQq2CUlv4bVdfpOe6fauP
	t6nsEVXy8nLY43g3Sk1Oh5Z/x4aJr9f5Bs6ovx1hgykpQ8EVHMWESWToOndjaL+GLu5Rs6
	UWNNxQS43TH9YZ2AsULspNccb7LBA+o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-diIi3B5DP6SAfMoGTVQI7w-1; Thu,
 13 Aug 2026 11:36:39 -0400
X-MC-Unique: diIi3B5DP6SAfMoGTVQI7w-1
X-Mimecast-MFC-AGG-ID: diIi3B5DP6SAfMoGTVQI7w_1786635398
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AECDD1956045;
	Thu, 13 Aug 2026 15:36:37 +0000 (UTC)
Received: from [10.44.49.172] (unknown [10.44.49.172])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6BC943000239;
	Thu, 13 Aug 2026 15:36:35 +0000 (UTC)
Message-ID: <a13888d0-e1d7-4f3c-9b50-f99df3951459@redhat.com>
Date: Thu, 13 Aug 2026 17:36:34 +0200
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
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Michal Michalik <michal.michalik@intel.com>,
 Milena Olech <milena.olech@intel.com>, linux-kernel@vger.kernel.org
References: <20260813140817.1051388-1-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260813140817.1051388-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 8/13/26 4:08 PM, Petr Oros wrote:
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

Tested on both branches net and net-next (after adjustment).

Tested-by: Ivan Vecera <ivecera@redhat.com>

