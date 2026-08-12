Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2599384CF2
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549938; cv=none; b=TssUpfWVEy7nCe+klIRdj9IB7SwJ90GjRJnC4dPnCi1gr1IPW3ChLmbRMVMSXHKprD+7Ev61t2UqPEwNo6jlTCtIE5RnTB7grTYwh5p6G6kWfO00dIMd9JQjTvVv8pyklVvQKP6pz5QaOf8SxOadhIO+TdgGK0ERKdzsbyrrm1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549938; c=relaxed/simple;
	bh=eNTolj4esumK0N14NtemcICTV33aWOfqW7hoeKZlWWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Es8nSR1ugURrQa2DTBgq0y1XTBv97Kwv2ozAgzJ/Dw+fj9v+pUu38GnFcHlVUSmn+OmyXCOYPp/H+hA2c6Pn3jM+ptzsHpWScrVuRHJFGSN4rWRQU1M1FzUm8XBGzL7Fv4Tx7wvBjXJ86wVu8mSGyB2onycldP+cHcvxLiXYhpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-49242309566so2388655e9.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 08:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786549935; x=1787154735;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RHVzQA6ZihVRnplScQr+oe/rmc9ShhytK2Xab0u8lDU=;
        b=MXv+UZ0T465UeWMBYuGbM8CnUjIqmk9FU6w1eOH6LqXEVTCvPwiZD6727ii/n82VKD
         vwl3v0afm+LAcGFnanZXEFc4rCVOHZ0cAQxbbps3ZkxYgg59mizQ3DBvuV3+5gSkCBdG
         a0S8VsmntgxTaMT7j8SINqEVZLwiwxfMuJaIHm9Jl8pJkdjZYssfJZybjzLyshdhfMSK
         GFTatND5kSbt7XL3l15fbQcqVFAA2Dgtwch/NWmzXpIE2G7wkXPEAtb6icDhrem/b0Je
         JMHq4HdQ0bytPBZky36OhufR4k4S77CLhwKPhs8cOoXsZKxPzH7rscQU/p7LPrEtSx+Q
         eH6w==
X-Forwarded-Encrypted: i=1; AHgh+RoZTesT8l8KeidHuAgin8hi2WAL3zZw9D0q9hoNjJlFp6t9YhII/oMm+dEUKBc+TV+yCovc6X8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qKIS6CfyTtd7mD20g7mLcqOK8bmY4SvQxr/kBcC3XT8JvS/T
	kLV5zBpL+lSb0GLK02zT6XuGY43bLpLWbobKh+z9jBMH8U9X4P1FGIe2
X-Gm-Gg: AR+sD131BH0GDUnI239bI0DPjYAGoMjKi2otnd7TS9fFFoGoRiENzxKHmWimFydnARM
	RxcL9KErPY/BffPFRBZl2lmOkmIMkYbACN4+AZWdhlClY2IOS4I76fwQYIiYAG62D2emTxMcrgI
	8QZq3sfvqc3IQs7vzTzVLKYHxlh8296vcnQfbXZHzm45MzDj/Y5RLh5w7aOn9lUwKPgHDkxHLEq
	/SgWKMQ5YVuGK5lMjZDyJ7VC0uRP7J6Kuv0n12MKdrR8/Vx6Z/3+o6MRrVe689JiWH0eRXtXMCl
	KUIi21DZYW6vCzl1vtGilRfrosoQ13gplVvCoqIIwHPPWptyhdatvtadUZ8oFN83nigus2GEWkY
	BWaSxLHr1A0bm1lmUXkmPq1SqWS39xw8wysOXcS67ZrODIzCVP5q8Ilr01hx+OgrQn6rRkNVHbT
	fJDxAYOTyl7bacayAcb9cSFsupyiEjXv4tDKgSmlgXr134NebDp5FFcm0aGdVdh7M+Dom7926Cb
	hiaGqmlJg7pMZs4w55rMftdB3Q=
X-Received: by 2002:a05:600c:3ba6:b0:493:e451:a9e1 with SMTP id 5b1f17b1804b1-4997c0e3812mr79337985e9.2.1786549934780;
        Wed, 12 Aug 2026 08:52:14 -0700 (PDT)
Received: from [192.168.88.241] (89-24-57-65.nat.epc.tmcz.cz. [89.24.57.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997c9417bcsm79337775e9.4.2026.08.12.08.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 08:52:14 -0700 (PDT)
Message-ID: <e532f313-447c-4ac5-806d-b686bc9181dd@ovn.org>
Date: Wed, 12 Aug 2026 17:52:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/2] net: core: propagate unreadable flag in
 skb_zerocopy
To: Mina Almasry <almasrymina@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, Jason Xing <kerneljasonxing@gmail.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Bobby Eshleman <bobbyeshleman@gmail.com>, Florian Westphal <fw@strlen.de>
References: <20260811195405.3979177-1-almasrymina@google.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20260811195405.3979177-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/26 9:53 PM, Mina Almasry wrote:
> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index ae69b2cabab9e..482893a5f67dc 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -467,6 +467,9 @@ static int queue_userspace_packet(struct datapath *dp, struct sk_buff *skb,
>  	if (!dp_ifindex)
>  		return -ENODEV;
>  
> +	if (!skb_frags_readable(skb))
> +		return -EFAULT;
> +
>  	if (skb_vlan_tag_present(skb)) {
>  		nskb = skb_clone(skb, GFP_ATOMIC);
>  		if (!nskb)
FWIW, the devmem integration doesn't seem well-designed.  I understand
that it is for performance, but IMO there should be a way to copy the
data on a slow path to avoid dropping the packets.  Clamping without
notifying the users that the packet is truncated is not a good solution.
Not for OVS, not for other parts of the kernel networking stack.  It's
a uAPI breakage.

As it is, there is not much we can do here without extensive changes
in userspace applications, so for this OVS block:

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
