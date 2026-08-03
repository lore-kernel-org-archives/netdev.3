Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA103603D8
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764575; cv=none; b=ahiAmJF/FAkjPZvmucrS465Sz0naUwmtJOxdxwpsocr07AHCaYhRUrIv18QYAd7gQq0DCsGAWdW1Ey8D/AN4wwH1thoue6yxAw8PQk21M7mREysCbAK7P07OJk5lAukWvbdkJxKp/VyvM20ukH5LcCFMfb5fzAwk+9PcwaZALN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764575; c=relaxed/simple;
	bh=7hgNn5i2CXZAeHNCzJI18FtpzkKrFl/iGqxowaJ9TbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hrx5rcMQmxy046IO50fkYeiGnEvJF+S6LQqEVWwyJOqsdQSq9BEFAVecf3eBI46d0SuroeryD0+0D7YnyPtitFYDPBL9Jd/0/asGE0qBzQColXf6J+frNifBHQBI0M5h/r/emCzJ3BZXpwa0EHbew/umvKmioubhBo8KgBKmtiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MoHZa2Xh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GoggpbQ5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoHZa2Xh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoggpbQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785764573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9mewyqdJBERhE/mcQ+h6iaGDeJtrxCLQvnbpvnUU7Q=;
	b=MoHZa2XhIJOrmkxA5sRBLSVEOGtJkc/ZGmDg3kV+inBeYMO7mk7yvxdb6PaW/3caQ0aZm1
	LeFji0QdY0JzmNlwrLl9PJbulr1XXw4BpCXTWS61ukxiYKY0zQfWnKQM45iW6XT0w79OqI
	NfA/flWR/J4WFyi5h7SCSl8fjH65m/8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-fRo48QQ3Pceljt92TxkZzQ-1; Mon, 03 Aug 2026 09:42:51 -0400
X-MC-Unique: fRo48QQ3Pceljt92TxkZzQ-1
X-Mimecast-MFC-AGG-ID: fRo48QQ3Pceljt92TxkZzQ_1785764571
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso15700755e9.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 06:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785764570; x=1786369370; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q9mewyqdJBERhE/mcQ+h6iaGDeJtrxCLQvnbpvnUU7Q=;
        b=GoggpbQ5rifIi+NcHUDIVYcnrWMnENUHp7cNgPOqrGAoJrCBaR+Hz4o0o2CnczdbKP
         rpdOXMn1f45fc+q6uZ3HkBYpXabpp/mhRbQkY5uMN5yYLA5VpeUpoVE6PsNvReF51DWZ
         9lv7RlRf51XoGUiGw3WxTTIz1FDcSaTLG69kN/JJJecOZLgZpKXaPbqa62TED2CRAm0c
         E+GsYJNqhC0ymOBHoheSLdsA/J9Nur1hUlH0BiY9XwY2lck1YFd53OLOwODPpArN9Ov6
         djhde3gFsvfquI6ruIHi43k1N5qHWtjUrKy1tvUTLi8T0XOhB2joyA8KiPwd3FznR9ED
         XyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785764570; x=1786369370;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q9mewyqdJBERhE/mcQ+h6iaGDeJtrxCLQvnbpvnUU7Q=;
        b=AznqUiAQexx/ZK1mHzPcpt2KwM195guHjMa5CpdubFNfiIlF0FTjxR5akuCu3O8ZzZ
         ii8PrTJ3lUaHF9YZzadthVNIhdQjPL/PD2ATNTL14Ph8U/lANJXiTc0k9+wmjkpbiDUe
         pnCVr4Qy4Jf6fod84Iqx15AyhdDaJ9RSvBKt3g1oTMy/cxWmJFYe5JlTujXZymP4ovJL
         bEzRj596dbhgYWreKI3oTL6xtBd4KtPG/kzC8qdYo3SruAuXJXyloz1uBi06itk4CYXW
         oLIExnCBNVGTz6UqDxZ0M9u1PnmR8TsOA77xzhfss4lc+0ipvQ7AKKzGJYFFBX6dnGxL
         zA9g==
X-Gm-Message-State: AOJu0YxjW3I+KPT+STF+hv1+HJ8mQbOzxqMakxxwFAYZsz/s2xZkxFNH
	29vSb1/Zahzp+lqKeQbL96txMm1vddAOffwKmPPt5G9wO4WvhevFxPxfn381trOcQkB1r/RC5PU
	uBbhQbxYRX87hz6Iaq47M/1m8fhXwSfh9/52Jo6qBsOGz6aKopYzL7vtJgQ==
X-Gm-Gg: AR+sD11ozNV/pIkCJgY9nwFl/1fBQdjAcPV61rSIPxYYzFJN4P9pbxOXml14a7Jt8cw
	HWQqwXv+Dwn2SIVFapm+F+sXdfhu/zXWSkA7yHEAPexdyePwRkplUpTFggqk3QuafJQwNs6/YX3
	lKmvSXr+2+f7T9EYeGY6ikGexT1xFsK9peOYC6K+7D6nsCNn/F2EGl5p9VPMB1CKXwPuLI9Ed2f
	OTduDAknzwBaM1l6UNfCyaSuh59hs5riDMAX/rnYxScxiTuGbARL8Mg1tZ96HDnIfJpEb70Suy5
	CxhT21gatAgJE2fqK0jq5q76vTQAOTQSYIHLXD2QDlH7EbtAQyJcFOiA+ezBQJcx3y9p0qx/VFQ
	/wX3ntUSDHDJwgr2jxwuE4snMEtizDHc1mJxhJk1t+woX9NDtRIbldgiMZaqShJcSH6YXAlIbpl
	s=
X-Received: by 2002:a05:600c:4fc5:b0:494:6baa:ccef with SMTP id 5b1f17b1804b1-4980f23257cmr218812965e9.11.1785764570708;
        Mon, 03 Aug 2026 06:42:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc5:b0:494:6baa:ccef with SMTP id 5b1f17b1804b1-4980f23257cmr218812405e9.11.1785764570346;
        Mon, 03 Aug 2026 06:42:50 -0700 (PDT)
Received: from [192.168.188.217] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458b73asm31017655f8f.29.2026.08.03.06.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 06:42:49 -0700 (PDT)
Message-ID: <22c1fffc-68c5-44c4-a686-6642e4af4234@redhat.com>
Date: Mon, 3 Aug 2026 15:42:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/5] mptcp: implemented OoO queue pruning
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, Gang Yan <yangang@kylinos.cn>
References: <20260731-net-next-mptcp-oooq-pruning-v2-0-24838164fa21@kernel.org>
 <20260731-net-next-mptcp-oooq-pruning-v2-5-24838164fa21@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260731-net-next-mptcp-oooq-pruning-v2-5-24838164fa21@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/26 4:24 PM, Matthieu Baerts (NGI0) wrote:
> +/* "Inspired" from the TCP version; main difference: stop as soon as the MPTCP
> + * socket is under memory limit.
> + */
> +static bool mptcp_prune_ofo_queue(struct sock *sk, u64 seq)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct rb_node *node, *prev;
> +	bool pruned = false;
> +	u64 mem;
> +
> +	if (RB_EMPTY_ROOT(&msk->out_of_order_queue))
> +		goto out;
> +
> +	node = &msk->ooo_last_skb->rbnode;
> +
> +	do {
> +		struct sk_buff *skb = rb_to_skb(node);
> +
> +		/* Stop pruning if the incoming skb would land in OoO tail. */
> +		if (after64(seq, MPTCP_SKB_CB(skb)->map_seq))
> +			break;

Clashiko noted that duplicate/old skbs can reach here, leading to
serious damage. It needs to be fixed.

It looks like opus-5 catches a lot of things that previous models (and
humans) were not able to see. It should be a :-) but it feels more like :(

/P

