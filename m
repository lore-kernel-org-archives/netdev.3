Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA1E35F166
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772641053; cv=none; b=AV9TzuGMwC2Ayx1RHVMPI4azQlsvCcb+qSoC8Iuj+WrBeugi1axFLOPw0HbnJaIGeoTfeTHxoxExDyH68ndr3Pe3DPWm+HWEn9aJ0nPXL6qWX0um0ZPaoUbiWtKB2A7ke7T7ISUqxVmRj3HK/kr11nveH5vAPsCktxtoA+jPGeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772641053; c=relaxed/simple;
	bh=Jvb1rVCOM6U/ZqwMEdVq2XIa/Y++7Mt5uVCXqrWQMRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lxk9XvBdEUg09i/ESnlDdnn2l5nK+cORKSpvYDt1O1WDjJMAPvUnFu3GhKv3QifftO3dg55byi6qwRmdLhZZaRKwF/VbE0RlwnNCJBzDO+NU144zwcfonOSQa6KccV1tjGwH5t6YP3HG3zQHq3DnlzphMPo6yYkvkt0utK6vkpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXjZZcfO; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXjZZcfO"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89a1347051aso26613536d6.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 08:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772641051; x=1773245851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yRJEH4pR8LqfPxQHnyHrv9zCGvjvaxYgR3oxj/WbAzE=;
        b=KXjZZcfOxzwN+IvLAEEd19+K4v97MiKyGS8LeI3d1J4IdPtVZUcfYb1kJNJOxZ1xIB
         8aCaAAgoSsFZNxWF58xxuriktBm6bEybXbNokt4rPxmF0OZ0IZbNgsGCvN9FYavY+9vW
         97C1tlh17ZkZbshuWhz2LQMlo1M7Xl7MJt0WTytvjGLbVEt/rfDos49+ZktrFlrncavB
         J+l7KEhXInhH1fxsfu5pQ97HItUFTTYwKNs76MbG8Ik50G24hfCoOtMSqigt0qEh3OCg
         PUgmfwslr+V0yNzLLjssIyZYNMyR0AXHpmBFmV/ChoN/GUhtnQJGgX1wzAEUn2sDaa0A
         ZGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772641051; x=1773245851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRJEH4pR8LqfPxQHnyHrv9zCGvjvaxYgR3oxj/WbAzE=;
        b=hTjIu5Gddik3sETxIdnG83G7ZfxjOo2J96fKrHQ882HYdUScc31uJfdSQNc5qTIHWE
         pTWPnoN6LVH/zeoJ8aSUjqdTk4wQjlovRE/UDTEsxPzDL6+jyUFZ0LmgEv4owQRnb3gV
         9NC4rPgiCo3T1PetICcqGVo96Xi0kWaZqrLw6ObhERzszJjNOBQ0fDn6ROzBXPKnSafr
         GGU0Z5VYk1F25WvSM8EembmuxZe6TkwmLlUcXFRXyblXepGhJEPPfQo/mba9zUb7UHcY
         S7QJU5fjF39sbCWDojcLxPRjWhVRXQstsArpsW8ijsHPCxDZLsHJz0MEPeanBVJKQIWb
         zzfw==
X-Forwarded-Encrypted: i=1; AJvYcCUzVbcuvY8qFPnG9VBzTBzZihGhwvtcd7/Lg1mlWjaB5RgSyBSoKk79DMqUYAFT0FYlzFTBwHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLrw7ShrYQh9wT51Tb/UrTemlsit7YDwQyf8BG7V4nNL+/CX03
	sytCL6kqUm4MeoMsQFNMMbIa8gBubJdy7p452fWZQ+rpfpM943qqBzyt
X-Gm-Gg: ATEYQzxPgSAOjoBAvxaUUxgy3EbpqUYWpKrPF1QKG0wC15FtKb4WcESC9RXCYQkfSlI
	DIAcgCAM1oHROEYGcrXrMarH/hGXwA3XNFJqL/ocI0+cN78vBf6leVgplnywoUMrFMs+L7WEcrl
	XKSL/wxUYjezJGAhChDzX7oCHhDdP4WXCclX3ii4qfTUwWSwBydChfr2lrvWMqPiVLFtmQ6uWk8
	QVihzKSSrtwdS2ayD/wGv/FFXVHWE5mhSKkcySQw/XO0tcnmPfG57SbWcv8Y3xl+IeKiFXaRUOr
	g7850TmQUg08DfiWAB/MYZdrge/YKyKJIZte2OTV69Jla8ICxxVIZCssdxUBpduYffk2+V/T2dp
	Q33CtKfIi4UQWAwhrhke9jAXiZlBvkmFIYPLpYY+dks632TkrtyUpfSicGg/7c/DILzcV5stPjB
	+1dURlzI19OV2zqRa5Yf3XB+yZOJUR0A1akXrJj/RT01EWKBgtk/sl
X-Received: by 2002:a05:6214:ac1:b0:899:e9bf:3747 with SMTP id 6a1803df08f44-89a19e41cc0mr32643356d6.53.1772641051153;
        Wed, 04 Mar 2026 08:17:31 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1145:4:d19b:d485:ed5f:e15b? ([2620:10d:c091:500::3418])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899f8f4c165sm77628776d6.39.2026.03.04.08.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 08:17:30 -0800 (PST)
Message-ID: <316b1fdd-f495-4a12-acd8-669ba5f2bf26@gmail.com>
Date: Wed, 4 Mar 2026 11:17:29 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 6/9] psp: Add new netlink cmd for dev-assoc
 and dev-disassoc
To: Wei Wang <weibunny@fb.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
References: <20260304000050.3366381-1-weibunny@fb.com>
 <20260304000050.3366381-7-weibunny@fb.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260304000050.3366381-7-weibunny@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/3/26 7:00 PM, Wei Wang wrote:
> +int psp_nl_dev_disassoc_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct psp_assoc_dev *entry, *found = NULL;
> +	struct psp_dev *psd = info->user_ptr[0];
> +	u32 assoc_ifindex;
> +	struct sk_buff *rsp;
> +	struct net *net;
> +	int nsid;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_IFINDEX) ||
> +	    GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_NSID))
> +		return -EINVAL;
> +
> +	nsid = nla_get_s32(info->attrs[PSP_A_DEV_NSID]);
> +	net = get_net_ns_by_id(genl_info_net(info), nsid);
> +	if (!net) {
> +		NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_NSID]);
> +		return -EINVAL;
> +	}
> +
> +	assoc_ifindex = nla_get_u32(info->attrs[PSP_A_DEV_IFINDEX]);
> +
> +	/* Search the association list by ifindex and netns */
> +	list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
> +		if (entry->assoc_dev->ifindex == assoc_ifindex &&
> +		    dev_net(entry->assoc_dev) == net) {
> +			found = entry;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		put_net(net);
> +		NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_IFINDEX]);
> +		return -ENODEV;
> +	}
> +
> +	rsp = psp_nl_reply_new(info);
> +	if (!rsp) {
> +		put_net(net);
> +		return -ENOMEM;
> +	}
> +
> +	/* Remove from the association list */
> +	list_del(&found->dev_list);
> +	rcu_assign_pointer(found->assoc_dev->psp_dev, NULL);
> +	netdev_put(found->assoc_dev, &found->dev_tracker);
> +	kfree(found);

in the case where found was the last associated device in its netns in 
psd->assoc_dev_list, listeners in that netns will not receive any 
notification that a psp device has gone away.

> +
> +	put_net(net);
> +
> +	psp_nl_notify_dev(psd, PSP_CMD_DEV_CHANGE_NTF);


