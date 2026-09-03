Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B1135E1B8
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 05:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788412158; cv=none; b=RAW3mukDYPg+wzG/Ly63uPToD/gHNpsPMzllNqEuxfkiemUZFQp4DGZ+jXp3g/GaUXlOtMF3nMCy0KVPlfeznBhkxxWVH3vRBTXEti2tjTwTQ062sS4uVuJQPAzcYpaaz8ckrvGroK5lrNdPutKRl5JM5mJY7S5gce7fxzaaJPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788412158; c=relaxed/simple;
	bh=uwoZsgRouGIrhRKPZcj3Ps59PD4lQcOoHkoPSOGiWms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxjOvcNdb6MgZMxzk2pSnt4fTdJus7JizOJWs96wY8lXH8fl6txdxbHz4BBW8rna1a8Kl8k28ZTIynofsIsAdzBms7bXWjy0gsRChtpy82u3EoZGw/6rzhVfZUBfrdIHcBxHtsbqOkNuyKJZ3qyOKIqpRQtP2lD4gm2mp7xwTJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2RR3t07; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2RR3t07"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8518b3ff3e9so1716274b3a.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 22:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788412157; x=1789016957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AEsAc2FwYgCrEyjqCaORwm1bF5GGCWm1AuGEwAPRkz4=;
        b=Y2RR3t07eD7W3jajbiKVBysdGh7+4s8knZoNZ23dxnlPiSa7QBPFKJAHU13rLHok0Y
         pgDHuOsLZ16Rf9KRfT56NAHotnb48arvW6/oGhtyP+xg9z6NGsHeGHAphowF+67KeedB
         RtcCK/W1u31PYmqjQ2Pn8sFBUKtxUyu3/fJ0svg7GkeUuz0WiT7NqpV8Tozdgw5QNDjq
         7y4oeJaLybQCWBdegWj6b64IKAfsP4njuxMTLvn5wSsky5GKKRECh1higc9sdTUVXNms
         cvIHRPIARDme2F/LgHXRDXaA0Mn/0x6dnUPfrpJCAeUs/dug4QbKWV0jyrjkWeFgKhqC
         fzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788412157; x=1789016957;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AEsAc2FwYgCrEyjqCaORwm1bF5GGCWm1AuGEwAPRkz4=;
        b=OPna/jUiXYPTYx7hp0tBrJP1TS7XyyZGT7QK0P7qaEgtj6u5J+2Nk8wwPQSTjxJYX8
         Kxefs8mearcPEWlGq30SkYyxuIa0HJzPzEQ43LyRuCqWoDNxcTucf3paXzcetQKcC6RB
         6DSoTOtNU7L+j1/PwGbAJKSX24Y1FbhipM30OkDw+IY26lQS1LqPzkd6hk7GI3Ug2lOk
         9S+5k7a/5corKbl3xzZNuDy1jTDUG4rHReoHcWo9zZrXepLVK/0f6/om3cUwLr9mRhuA
         i9WhUxfkiB6uTBX9jrUmfu3T/yuMCKPCQc8HC1i3mlieO6xTmZF/jKcc+VBoJmGtdhyZ
         KbCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwUUUg3srB7kQiq1WLexaL0pxlrMpU3dxUM9/va7irvK6tNgHayPCeBtGB3sb683Vb2tUSPSE=@vger.kernel.org
X-Gm-Message-State: AFuF++kcfcHpg+1ekJxrwH2W4HkXSqMPef4C1xJPgbF4grSvqnFVgM1K
	kgY7L1ThHnt2A8z2GTGpxOf9XaHkerI9/GQTnS5h84Wss7PJf1pBC/vL
X-Gm-Gg: AYBFou3vBPo1I9Xv4lebgQXOQvgL8wcyaI8Blg2x/VI6yEa8yi7XT/x0UwmRw8pJ8uO
	H0HHd4Vz1wBK0P4kxHcaRQCC4EvGxs4iZDUVVQ4hVah737Z29iD7m/dUD1gn8OaIUpxUB5jrDnP
	RuGtl0i+4+gTc0kbT5LUw+tC9NWFw820EmG0ICRGpGpr9guWwePpo9GbFzx1MUPvj/QDye3W0Tm
	Y4alLPRbwJvSAOfJJyGQykgRHyI6NKdGIrNf9CM5/e8EpBQlVXlZBWWQvB8fpYhs+zp8JroW/Lf
	fj430CfPF0fDqe5g1i6fU1l2rmehm4D1K5pC1wtW3PbCamtD6qytnPD4t6QRQQKBSglP3HYmBJ/
	fe1s3xQeZfoI4I0N4PP24t8J6jcKbSnxDT/vMRrwmOL35eOEtYUshdX2zqmsvGH4hyZygVjsIHA
	MBpmpWSpEli8V+EQb9KVtrQoXkCz1q0XyTewn9FwXcJkseVYCi/80umQ==
X-Received: by 2002:a05:6a00:ac85:b0:848:76c4:fba9 with SMTP id d2e1a72fcca58-85ed23ded47mr15880315b3a.7.1788412156830;
        Wed, 02 Sep 2026 22:09:16 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc0d052bfsm2161587b3a.52.2026.09.02.22.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 22:09:16 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
To: edumazet@google.com
Cc: andrea.mayer@uniroma2.it,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] seg6: reallocate the skb head on L2 encapsulation only when needed
Date: Thu,  3 Sep 2026 14:09:05 +0900
Message-ID: <20260903130525.28296-1-yuya.kusakabe@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CANn89iKUqjbrRkr68+S9nKAu49C3K01e3XSNwkY1NCgmuPMPag@mail.gmail.com>
References: <20260902-seg6-l2cow-v1-1-e823ce216454@gmail.com> <CANn89iKUqjbrRkr68+S9nKAu49C3K01e3XSNwkY1NCgmuPMPag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, Sep 2, 2026 at 11:00 AM Eric Dumazet <edumazet@google.com> wrote:
> This is a nice improvement for forwarded traffic, but locally
> generated TCP traffic
> is still hitting two expensive reallocations (second one in
> __seg6_do_srh_encap())
>
> Can we combine needed headrooms so that only a single re-alloc occurs?
Thanks for looking at this.  I will send a v2 with the combined
headroom.

One clarification on the locally generated case: seg6_build_state()
does not redirect the output path for the L2 modes, so locally
generated traffic never reaches this branch:

	newts->flags |= LWTUNNEL_STATE_INPUT_REDIRECT;

	if (tuninfo->mode != SEG6_IPTUN_MODE_L2ENCAP &&
	    tuninfo->mode != SEG6_IPTUN_MODE_L2ENCAP_RED)
		newts->flags |= LWTUNNEL_STATE_OUTPUT_REDIRECT;

Two reallocations do happen on the forwarded path, though: with a
header-cloned skb whose headroom is below the total, asking only for
skb->mac_len leaves the second reallocation to __seg6_do_srh_encap(),
because the cow that unclones the skb does not also make room for the
outer header.  So the combined headroom is the right shape either way.
