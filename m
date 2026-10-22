Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792643768;
	b=vU6QL9LKzMlr/Ed1Mf96670WpUh/Ob+gQAbr4suJbezJjuwWwckHRhUDXygKLHrpMHvS
	 JE0DbsEw2vuSHYDrkdt+NNgszDB0d0U61QCORFeybpcMolCHM2m7PFKj54m+zdq1n1h2V
	 iWljtAq5momyECKyafGraTCsiyqgBE0L1xncwLfWGzs6PsGW5iI/FtWbS0YVU9ohr+Hys
	 M81bV4O7Ukg0qFGNuNlspnwePKZfxQUXlP36x4o01i0Oe+MOLaGrOqCyh/PTkPpUIeEiU
	 k4fL6ax/UjjGhXoDxBMGUWxcI3IUl8yvz3bTBI1IQK9okrUpOW2Mt4RZwMW3Ui14Olg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792643768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/7tpPcJ0uUKLTHvPEfaChoh+KwUwTnCA4Qa2nt1mS1c=;
	b=y0m9oIzUPA7zQKuYLpmIVUEvMNt3/kV/J1BvWDH17Ni0JGTqr4YtRg8wW0n30JbFk2c7
	 768fzNECPspV9NEUgUVX5xEej5QwNIbMkXcYcjv7/7FpSBjVFYSXvgwcjmXA3ZaXhWyIh
	 uhkViGtmLIlVbf1bRhL7yRGCj5+QEiv5KfYy231yagULhkckvAX12RZdKKHI/I9R0Tk8v
	 DRKKjxthhs+sUgVLKbDBMgrFLDu9aQpgCyrE7gVQ09fFoPGQlqOmos+oAWd+BTZ01yShD
	 dvbuS3NorgjTZXvhPgtp43d2WEIRGmxeenfMd10PSf0SoWkGE1fX8gLuMUXdRdfpKpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=smartx.com;
	spf=pass smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=m3KRsj6i;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC69606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 04:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFC69606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=m3KRsj6i
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1846bc43c28so487536c88.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 21:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1792643766; x=1793248566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/7tpPcJ0uUKLTHvPEfaChoh+KwUwTnCA4Qa2nt1mS1c=;
        b=m3KRsj6iAYqkj4vEeMUdHfEuLT6b58tIMnR6uKmMidgysRguWHudVAURWLIvILb7PE
         ud//uHY47+iLHj8nvAlJtHxA3rg8LSxuyP+4HkNNTIgadWIQWCSz0y95pIGvieTmYPI9
         KBlzU034rtLpnEYuyhzOwQC655A0sSOci/G/0OEu9lro7Tyeh25lxGDXf4fTkrYAdleG
         RmwN7gT3VHyRC5+Ic6fXbav299lKI3rk5sn+BLZejIeTxrrItiH0KT2wZxBrM8IQyZoP
         jSrRBwOIYWlzQb+2U4lEMqp0A6jgpiwZ/Wy69QNOtHm26p8skuZSOdyYugqVx2NEjsjX
         w6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792643766; x=1793248566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/7tpPcJ0uUKLTHvPEfaChoh+KwUwTnCA4Qa2nt1mS1c=;
        b=NoJOI79FPpA5KHIhikLukxMl82A/qV4p2GF5+ys4llGPZNLWMQ5VB5wv8hlPPHdQDm
         zpw3ASDShvKTBARBEMju2B3UbVbPOrGxNVVmwytcYTIunoUyz6JA5U/Dr9GoMOvhRVc7
         Kacx0tJiIQHvfjzkbeg5C45EXMJwxadciOGQc4ZPRXSSopceQa8CcXzq5csyOjDtpp6L
         wcnQA2AVSe4tKFVJZyZcRRWtz51EjRBYDxcvWkSa6KmeBGg/Kes3WhEgJxLPo1a8uQ8x
         IYOqUbk040r/ZO9YDsW0Obl/H8wylB6ytLK2M8YPaxIW8EvDElljEJ7n6dsd4Tuijt/G
         ONQA==
X-Gm-Message-State: AFq9FYLFw8FB6aChMv1laSGhzlF1b0jlZ/hL/cTL0CEjI46XF2XLyTID
	r5kn17sOAfsXUGffKQd58TOmzWIMYYimGR7GHEqT/NFr9z6ziQAofFDGatB4LYOhrF0Bc8L4X8u
	QzZAZUsv3f72RmyTVwSOiEoarrP3FNB60ZnxKvNpmXvCPWEWU1jkNnuk0aluhha654elAwgE0
X-Gm-Gg: AYBFou3rlzITNROxDnnYpobIgAVdpAtJSN0FcGzsppCL+ImerZ2Xr+cE5gtlafcq/Gs
	N2AYeTW44rNJIbbWnTfRJhOGfG7Z9jEd+62HmRj1/cx9m3ULlvbjxtv/NVmU8WgqEW8fqXJN1Y3
	uND5cFpqDEgEUJyNi2LoM3UcrwtrTypA3W/paL5r+Z7gX6dD3MUaeAUjzdrK14mb9sF3zSGxU+J
	NDEWLptYwQD0dbWnta7kzuLPg8DBxL3zGCDBl1qCcBheHd2fmNKFflFu8b4SNTF6J5uq7EKxzeh
	cO8+chSp/QEok2MJYIz8yAiM+JFUKupRGB5jNOruofkp54vyUpCHuCKbJmDMntsYmfEqZSHkfNR
	Yy+wZZG7LAH9TyjIQMfUrtpCQ1+62doCVxJK0nymY6kgcdVBRSCXku5t23YbAQVyu3LqWl0x4Tn
	matz+4s4G40fuz9+kcJsxncCeZcz95Qnfv6tMZqqmtP9NbykQb2l/SykVCcd4dc5416dHzwFuhd
	jMb5w9i1xkXTtWjfjwQ03IemTALAKhtlIJqgUbIWpgLsC7giMnzIjE3bifj3Q3otx2VTg==
X-Received: by 2002:a05:7022:43aa:b0:187:ec67:2fc5 with SMTP id a92af1059eb24-190a5d7115dmr7374488c88.32.1792643765232;
        Wed, 21 Oct 2026 21:36:05 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bf5d0a1sm11178696c88.14.2026.10.21.21.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 21:36:04 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Cc: Wang Zhan <wang.zhan@smartx.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Simon Polack <spolack+git@mailbox.org>
Subject: Re: [PATCH net] net: fix frag_list leak in skb_segment_list() error path
Date: Thu, 22 Oct 2026 12:35:37 +0800
Message-ID: <20261022043537.3481475-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021161858.761205-1-edumazet@kernel.org>
References: <20261021161858.761205-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 21 Oct 2026 18:18:58 +0200 Eric Dumazet wrote:
> skb_segment_list() detaches the frag_list from the head skb and moves
> its members one by one to the skb->next chain. On error, err_linearize
> frees that chain with kfree_skb_list(skb->next), relying on the members
> not yet processed to still be linked after the current one.
>
> This does not hold when the current member was shared: it is replaced
> by skb_clone(), and __skb_clone() clears ->next. If __skb_linearize()
> then fails on that clone, the remaining members are no longer reachable
> from skb->next nor from skb_shinfo(skb)->frag_list, and they leak.
>
> The skb_shared() error branch already relinks nskb->next to list_skb
> before jumping to err_linearize. Do it unconditionally right after nskb
> is added to the chain, so every error exit sees the remaining members.
> On the last member list_skb is NULL, which still terminates the chain.
>
> Fixes: 53475c5dd856 ("net: fix use-after-free when UDP GRO with shared fraglist")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Cc: Simon Polack <spolack+git@mailbox.org>

Reviewed-by: Wang Zhan <wang.zhan@smartx.com>
