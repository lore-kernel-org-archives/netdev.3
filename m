Received: from mail-wr2-f43.google.com (mail-wr2-f43.google.com [74.125.225.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7B3515C1
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856189; cv=none; b=bxInwv5wVyc1p+tcpUDqALUdZDrzMuDNsQsH1RSI1jDnNLI2xDAPcpnKaAvD73vY5Rq+q2dO7lSrFyhvm3gyrvqu5TlDtl38F1ATl6pw5enwu0r4/x5iaEeNH9+IWhZVSaz/1LCUMjqzNy3n8bsC2viEFodmVxGrkoh++AdIIP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856189; c=relaxed/simple;
	bh=xiogtjMtB6wCIIbyGGo4QNiF7Ji8CL/sbE8HNl4iyjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4nh/IIkRZNyg5M9dBfSrfzEjAxGSdzZebFwfre0By0qkku/YL3JQIogHW9xdtE3VRie3kjkHgUORLAJihjLDtoRzob5WUqc02paSBEgU1HsPv0NCv4Rw7//GHpvaIfIC/B1UrdH5EsZQHkNRc/kkOrKk0LUyOnMwr4ap9Iw9FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=FFq/Uj29; arc=none smtp.client-ip=74.125.225.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="FFq/Uj29"
Received: by mail-wr2-f43.google.com with SMTP id ffacd0b85a97d-48b024549a2so1339532f8f.3
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 05:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790856186; x=1791460986; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QAee4xNfaxXZxk12pcan/SMbXVDN86ECylJmXyJsoN4=;
        b=FFq/Uj29h4LdxFCJNj0O7ARLhROJVA3P7zXTX8d4BYhfZqFgpix6kiUgidbd8WoMxS
         LSd3G0vW35P/J2fIDzPaaQCFeLHHoFgZB0RV6L1GPREcxzpPl1RCU/XxX/bJ+ijmVhiC
         3Z0JeDAlGU3XTEwIHssYiZ6seSR6K9YJF+Jozyr7VNxpLZFiPjEL1P1q216fSZHHcIgI
         ciRHzqLL9zENEuHe5/DaII6Ddznpz0Dg+0a3pBN5namHhTyDAJnuWjH+uA6UbPGmeNqA
         Og1ra5Tk2QEvlcloJ7HkFEKe3TaSsgIdD0Nh2RbsmxqoyFw+wti48hZc7E2vK+qynZKD
         uuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790856186; x=1791460986;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QAee4xNfaxXZxk12pcan/SMbXVDN86ECylJmXyJsoN4=;
        b=VnJfO5Q7f30Q8T2bsRzh8YLiDraZimJ3qzT3JRCYsuQCv4VmDAxO2GY2xWS7mqyL5p
         R63nVFLtgDx9CP+/D5HVpNV50XLT8Wgb6z94sbMuUQr2LK4Fn+KocFmD+hAi2p8gS9M9
         xA1n/233CtREGrxUN0pNVF+AVtKiyiG4Z15TYqJT5VoItKp6eJPVec3EUhKT2YGB4XX+
         5hgZSXRLJ2s2qWQh2e6gpNsWTwYbGoGHqvV+vrM8qAjxk8rDnwbPBHqNKYnWyeZxII5G
         eR36n5fvgf0bZS/nPoyIECAWniUQcvDb/OdMQ4a7C5uLMORYn0HgNF9F8NxVPyNCnpSL
         TnUA==
X-Gm-Message-State: AFq9FYL7oMLNEsTt87wVxvuViABglbqq4m//ub0giaEKlfWblL2uTRmU
	zNZvnB5HwubSdM6tT1ymQW6kwvx0It92vVIruV/HZPIMkcFEnnN9HL4oUPit5Apuatg=
X-Gm-Gg: AYBFou0XhFtepYb/ehJnVD805T9/CRU3frlwnOL6yRJI3m/lQojSSgxuq5dvK3f1+WR
	zT50BS79kE7e1FCAc2QGVxP5n0QvK9/pw5NQgNRSiViV47HFCoO6lQc5WQ/7NW2vCzeLEwKgVQD
	483FI9lT2suxgTwuaj6IA0gsfsHss2q2TyN7PMh1ieCC9HgTRQ4QmgqWNuix1WFO9blljqNznJX
	V+BdXo9XbLXCZepzMGtE7orm4BfssAcKoXlKoeD06zBm3WwVo3Nmsuuf2Vwr6D/f8Su/DYK8b8I
	aZntrPoFYVQQvVURR0DdCvkQ/2HI9NkiNbBt5NaE/l0ZWfOSef9UjocxwouMgcwgKLdz0epNSOu
	IuWkG7fxJT7IIjqk6z70EQxHzPNqe7xpYNv/iD50iJkCPzD3NzhjexTKc7a0UD5sFiV6dtqeTsS
	Aluwtx/bndwKd3p3z+1Jrg62eKDJs0BwZ5f5XRJjPJWpn8QlFgzW+UKyNrmZ8LsYoo42yNztjY7
	14jRfEZzZgi1wKbb39zrp5Ut7wC
X-Received: by 2002:a5d:5d83:0:b0:488:8384:c382 with SMTP id ffacd0b85a97d-48b025325e5mr8036844f8f.49.1790856185689;
        Thu, 01 Oct 2026 05:03:05 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0690e19asm5870743f8f.18.2026.10.01.05.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2026 05:03:05 -0700 (PDT)
Message-ID: <679483c3-5fba-4208-b05b-aa4dfba28f46@blackwall.org>
Date: Thu, 1 Oct 2026 15:03:04 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/12] net: bridge: add VLAN support to bridge
 destinations
Content-Language: en-US, bg
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 bridge@lists.linux.dev
References: <20260930071411.2786201-4-razor@blackwall.org>
 <179085594902.434549.16785666588384507596@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <179085594902.434549.16785666588384507596@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/10/2026 14:59, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] Baseline decision: false positive.
> 
> --
> 
> net: bridge: add VLAN support to bridge destinations
> 
> This commit sets bit 0 of struct net_bridge_dst to mark a port-VLAN
> pointer, so it can be told apart from a bridge port pointer. It adds
> helpers that build VLAN destinations and decode them back into a port and
> a VLAN. Nothing creates a VLAN destination yet.
> 
>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>> index bbb59b53e7452..2bf7f4429a3b2 100644
>> --- a/net/bridge/br_private.h
>> +++ b/net/bridge/br_private.h
> 
> [ ... ]
> 
>> @@ -702,10 +704,56 @@ br_port_to_dst(const struct net_bridge_port *p)
>>   	return dst;
>>   }
>>   
>> +static inline struct net_bridge_dst
>> +br_vlan_to_dst(const struct net_bridge_vlan *v)
>> +{
>> +	struct net_bridge_dst dst;
>> +
>> +	ACCESS_PRIVATE(&dst, value) = (unsigned long)v | BR_DST_VLAN_TAG;
>> +
>> +	return dst;
>> +}
>> +
>> +static inline void br_dst_decode(struct net_bridge_dst dst,
>> +				 struct net_bridge_port **port,
>> +				 struct net_bridge_vlan **vlan)
>> +{
>> +	struct net_bridge_vlan *v;
>> +	unsigned long value;
>> +
>> +	value = ACCESS_PRIVATE(&dst, value);
>> +	if (!(value & BR_DST_VLAN_TAG)) {
>> +		*port = (struct net_bridge_port *)value;
>> +		*vlan = NULL;
>> +		return;
>> +	}
>> +
>> +	v = (struct net_bridge_vlan *)(value & ~BR_DST_VLAN_TAG);
>> +	*port = v->port;
> 
> [Severity: Low]
> This isn't a bug, but br_vlan_to_dst() takes any struct net_bridge_vlan
> pointer, and br_dst_decode() reads v->port without checking which kind of
> VLAN entry it has.
> 
> In struct net_bridge_vlan, port is in a union with br:
> 
> 	union {
> 		struct net_bridge	*br;
> 		struct net_bridge_port	*port;
> 	};
> 
> For a bridge master VLAN, br is the active member. Decoding one would hand
> back a struct net_bridge pointer typed as a struct net_bridge_port.
> Passing NULL would encode to 0x1, and decoding that would dereference a
> near-NULL address.
> 
> As far as I can tell, no caller can hit this. Later in the series, all of
> br_fdb_update(), __br_fdb_add(), br_fdb_resolve_dst() and
> nbp_vlan_delete() pass a non-NULL VLAN taken from a port VLAN group.
> __br_fdb_add() also excludes the bridge master case on purpose:
> 
> 	dst = p && vlan ? br_vlan_to_dst(vlan) : br_port_to_dst(p);
> 
> Would a comment on br_vlan_to_dst() be worth adding, stating that it only
> takes non-NULL port VLANs? Something like
> WARN_ON_ONCE(br_vlan_is_master(v)) would also enforce that.
> 

- No, that is clear from the code and its usage. It would be redundant.

>> +	*vlan = v;
>> +}
>> +
> 
> [ ... ]
> 

