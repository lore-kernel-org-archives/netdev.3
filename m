Received: from mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7EE3CF942
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788695081; cv=none; b=RzHqn4j0AfctmoRAlHq7HndLbzvDnr8jxuHZlOx2kH5HroChWtb8XQ33k7VDUQhG4eq5E8DhdWGvcsqqsjCQBS9Ale23S8RVhOBFkLktxhwt/0Jm8NUivXxKYCHQyPpuxMbdQAAyi3JUSFgs0ZDIUFqSPJtwcsVorbeGbSkM+zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788695081; c=relaxed/simple;
	bh=1Gj0dtJsotUr3Qaj19BNyitbww7Tk+cB4B6grhHSiP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tp44TC8RFx9P3vnXNqH7v61xh22f2Robjv04J9yd+8YbxAWcIS3KampjG87oGNlm5mDOzYs8/c2e6GqLxFkc9f3sFFOTox9SOArZEefTSmeUINvQhWYhwW5ZzFGlbxzA9aFCwz8yQxld4D5xCJFJUnbejLVlZDe25XOxjXivQTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wvb9z+sK; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wvb9z+sK"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1Gj0dtJsotUr3Qaj19BNyitbww7Tk+cB4B6grhHSiP8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788695075; v=1; x=1789299875;
 b=wvb9z+sK4WriY5ckLvvkVxDf2uEXKMECe4Xxz8yKUNdFUxrjromjQDzNZ+Rath/cKdzwa1hZ
 czO03QoFqlRLG3OAvBKFTk8nJgy1MnWl1SdlQJdjrfZ3vxPst4YO8L9nnEOU6m3o2ESSvuHKLWN
 g00Ll/8ZVqpWXyQdTOTSYEa0=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a58ff5ba0496e691;
	Sun, 06 Sep 2026 11:44:25 +0000
X-Mizu-Trace-ID: a58ff5ba0496e691
X-Migadu-Flow: FLOW_OUT
Message-ID: <43cbac2e-d0ec-4315-b5fe-5a51745fce0d@linux.dev>
Date: Sun, 6 Sep 2026 12:44:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] netlink: specs: dpll: drop the pin-set
 attributes nothing implements
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 arkadiusz.kubalewski@intel.com
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, ivecera@redhat.com,
 jiri@resnulli.us, donald.hunter@gmail.com
References: <20260904191023.3869690-1-kuba@kernel.org>
 <20260904191023.3869690-3-kuba@kernel.org>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260904191023.3869690-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2026 20:10, Jakub Kicinski wrote:
> pin-set advertises top level direction, prio and state, so the
> generated policy accepts them and the generated user space API grows
> setters for them. dpll_pin_set_from_nlattr() has cases only for
> FREQUENCY, PHASE_ADJUST, PARENT_DEVICE, PARENT_PIN, ESYNC_FREQUENCY and
> REFERENCE_SYNC - the request succeeds, does nothing and produces no
> extack. The three values are only actionable inside the parent-device
> nest, where dpll_pin_parent_device_set() handles them next to
> DPLL_A_PIN_PARENT_ID, which is what makes them meaningful: a pin can be
> registered with more than one device.
> 
> Never implemented - "git log -S 'case DPLL_A_PIN_PRIO'" on
> dpll_netlink.c comes up empty - the spec has advertised them since
> commit 3badff3a25d8 ("dpll: spec: Add Netlink spec in YAML").
> 
> Note that this does change what the kernel accepts: sending one of the
> three now fails validation instead of being ignored.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

@Arkadiusz was this a plan that never happened?

Anyways, LGMT
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
