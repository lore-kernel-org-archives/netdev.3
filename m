Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474838C2D0;
	Tue, 18 Aug 2026 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787038908; cv=none; b=MJ61CYhiYVTJhhBfrZvBO4FfbgM7gxed+e2cPPuc7ncn441RxDYuFpRSEsnqSvLZ6Q5mqK6XltRMQJ9cUH4V4bKaXzShci5Bd/nQ3NT+DwpvdugzVa0dC2a4+aG/epyuBY+IY9/KzjX6J+dGZtx08OOqeFm8n9a16F17XxxGzLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787038908; c=relaxed/simple;
	bh=WJLrsvW1KgVUoORHlEfWwIngWQzHXJzyHjRUcNkbe4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPKcIBXt14veOm3wevhjBskOxw0jeC5gnqQgjFNsUCYYAzllYGig3SdKZFAzBfqTNsaEA3aKEqQbMTmo9GwlRkHXdXuo+EqAqaLeN/TBvahLA0LRZDTeZlZaovMMjkdhdPdEHg8K5CypD7L+hmDNda8bJlCWCIpvXEzcrbgv1mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqqJk8XT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqqJk8XT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7E81F000E9;
	Tue, 18 Aug 2026 07:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787038907;
	bh=ekUkHjTKM0gbzEISO/sz6tlY6bNtVcf9G+2Ep4ZlXcA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QqqJk8XTMs/r9JUA8w+ttb8o7C8EeUSBl9heAbvqWAtyvt4d+nF4rEnjE9WR6EHhq
	 S13Iu55lNBiolmz1aB+O20LCrpHGWTefsirl3A/JVfIjZ1VsaQR6GgGnonB3fNBUuR
	 09a4uh+/Xa4qflhIocFS59lNlxOC6lHSMr65aKN7JTIHW/2VSb4BvnT/U46NQWe2Ms
	 zyifoFDh/qM0QkYHk8ZNXShKzZheO+DQjlmWKyO8nmBXQJbGad+hGsCMBiRtJYpjmr
	 b8PcXMVrejp5tuTmxfO+YYoevt449INrzXkCod118HUIr6e54SAv0Pnm4970VpJvXU
	 3evp3KAdpVYYg==
Message-ID: <33ade507-a389-4ace-8635-a4cd63904a16@kernel.org>
Date: Tue, 18 Aug 2026 09:41:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v2] dpll: fix NULL deref in dpll_device_ops() during
 teardown race
Content-Language: fr
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Michal Michalik <michal.michalik@intel.com>,
 Milena Olech <milena.olech@intel.com>, linux-kernel@vger.kernel.org,
 ivecera@redhat.com
References: <20260813140817.1051388-1-poros@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260813140817.1051388-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Petr,

On 13/08/2026 16:08, Petr Oros wrote:
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
Thank you for the patch. When merging net into net-next, it looks like
it creates a lot of conflicts, mainly with commit 84e85c325e5e ("dpll:
use pin owner's dpll ref for pin-level attribute setting").

Because the logic seems quite different now, do you mind providing
instructions on how to resolve these conflicts, please? A 3-way patch
and/or rerere artifacts could also help.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

