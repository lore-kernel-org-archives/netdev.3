Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794141341;
	b=OMRAcLSITHX4eX6BaafuGaIBcFx+bdkv1zwJUpPdXkPrvBy3efi/eP3xfRIJyRU7PqDj
	 lHp/rykytiT21WfAhsLOgP0Ni/LNBlg1drP+QN356fEDqEJvxbgyAp0S9wegdJlp9LTBJ
	 z+A3KHWcrFGLxDeVBvvQn5VupRacClPwQMpPIiu1Hg3mBt5Kkg4R2tX3I5SFsfkYo35JR
	 9Y1uLUr0vrWdQXhbcjB0YUSSm0f6kleJ2b226yM7sBqC16YadHq5rK78UO0Z05m7pMHDQ
	 88/N73++8BTwg3c2UJLM1ciLxNxaYNfL3CM9Ai0jEi2OE7IXOQs5FVuDKDKm7R5kH1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=BsIqDH2uBIw07srR7JvSFFgacKj9qHr7Bysu5dj2LaQ=;
	b=gXXWoJ8pBddURFgenNrIa8Sv2OqVmTYKloUGUnrZkUG7gKA66CtlHxDtvI0lSyEXTw7K
	 FCWm4je7ds/I+BWoJpuiYZ1+sakz3B6QdxspETV9rhJYGzikKt5NMRGV1zlPq/MKsFAcv
	 XZGfowNC2aBSIe7Gc2Pns8eeSRnZxDUPiRLs+VRVPy92CEIzHDS8agnxlf+AEZfojM+bf
	 yg3QC0h3lGDlEpohSfmoDwCM8QNjK5/an8s+L/VCb1QVEG6qjvHjzV7Gdo2iqbmUN5iRM
	 p2s5bpQTNPvDDQvIsV71ROwoAVFYc612CC6nwraD8Py8gFRpRy72EtDWKBAoz8YQvAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c+8q2x3i;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3141C606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 12:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3141C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c+8q2x3i
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67bee1f693bso22288d50.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 04:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794141340; x=1794746140; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BsIqDH2uBIw07srR7JvSFFgacKj9qHr7Bysu5dj2LaQ=;
        b=c+8q2x3ibzX3DXzv36nytcJfoaxql7mkrXSZ1ykHvC2IhuVHo6W/fsqeB0shu9wl7a
         6W4w/kP17+wKfkTqjwt3F+MERyu7So4fAsTAwuk50DnjtjfXZQVRsmEhlJ521I3KrC9p
         3ZO9RCIjfd10csfppZND2Bhg0pXH4pUWhxPCHX7OSLiNex+WjU7anHQ+N5RzVUyRGxRy
         hFn2vRdGbo/AO+WxA9IQeFHcKLAEI/TBjdj63deXHdOpI59bnMLep0KJxxR3QjXznRf0
         I7vMuoqnmfbwLRK0hDoNrtOCLd0nPU021BlLLlC+5aWDP29xDEtDAUEiGWVSIPVAUjPl
         nnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794141340; x=1794746140;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BsIqDH2uBIw07srR7JvSFFgacKj9qHr7Bysu5dj2LaQ=;
        b=NMxHAWXKgeR3IkuJ6OC8kSNuwWI40t1rLYr//sr69sa9o/Pwx3gCnN7buNZ1L4e5MR
         rmtleF/9MYYoG28hDgu8hCFrtNpO56T+UGe0qQ5WJPwmd8PQd4cNI6Pz5duIPQLwEddz
         O+WyHkdgQ/O1a82sdWZ3y1gRZINwsx8vI/UI86s9DkCK95wODp26bPYt36l4qhU0ODhv
         rqAGAFUT7Bci6AvR6ylsTx+PYU6TkcPZl7+JK+36Uq6YvWNjLy/AWkofvVQ4LufvVslu
         3t78ZChxHrOIy2c4v+VeWn+vriPwD8GLfgWZFm7Z7tJLM67tEEj6uy1l1AL1fSPyIEQ6
         bg2w==
X-Gm-Message-State: APuU4Z97jn39YXtoc2HpuDXOsi+QBK7noREdYpNm1kqPDueMD6cx3M1U
	MuqE41EpXMz1Hihrm33E3sGh7zhWZmQZmMW4LY8owPLr5eiPq+8y8NP5eaOc5kv1
X-Gm-Gg: AYBFou1DYs5+ii8f4vGWnPTCBS2PmNxdtz9cyIy/s50gJaU6Vri6aipgU3Vsv+hSyLk
	YZAnm3tYVdK6GGvqrvbaNPU9LC2J0Ah+tz4ecQbEQJQmQZ22CXYv8amBaa67mYLyBJUjGf4qhMK
	nCVFJSSt+KEVxzyhSFoOixhoe1C5E5MJJlOzznZg2HTGeBugRsBV96NZ7DpJBjgqHJHeXZNCPid
	WgE1FCuQ1h2dNwfFUY/aS6vFb12iSOpujPnEVPhNVgdtJ0xkbH/6Aw8TLU+tmutSVDH12jOBEZh
	KFabOuz7dbUvnJkr351nRrlYEdmakmimr6R0GISMOiB/nWsJbL4VrEC+1qF0hrNYf0aPZ8cZks4
	vbIaCrnWOPu7xEwPx/LeX+I0vseKyEqIs/02wip64IOCVJt2LYhtGktU/owwVGzlXOzXT13jsMs
	LPaL71syINTz+9JOTiRtPLlnPMWGYpqO080tjjFHkP4IFNq8MapJBSaYTYAhnab2UltVJJMyRsN
	QpoG0fWauwDyGT9hHMUidgoG/DRe+WPYz4oaXqsz3a8QjYqralcPoXPMN9zbPXlivNAq7fsbHIr
	l3mPJuKYSpb5oOAnaWZpxe/s+Jija6THTkU=
X-Received: by 2002:a05:690e:441c:b0:67c:608:b375 with SMTP id 956f58d0204a3-67c3da7825dmr655795d50.101.1794141340146;
        Sun, 08 Nov 2026 04:35:40 -0800 (PST)
Received: from [192.168.100.12] ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c3b959615sm1680270d50.14.2026.11.08.04.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 04:35:39 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: netdev-bot+sashiko@kernel.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Paul Blakey <paulb@nvidia.com>,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v1 2/2] selftests/net/openvswitch: check that a failed
 set keeps the features
Date: Sun, 08 Nov 2026 07:35:34 -0500
Message-ID: <179414133477.2826493.3370183031916994716@gmail.com>
In-Reply-To: <20261107113403.797779-3-houminxi@gmail.com>
References: <20261107113403.797779-1-houminxi@gmail.com>
 <20261107113403.797779-3-houminxi@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Both are real, and v2 fixes them.

The Medium one: the else branch treated any failure as "the key is not
there". v2 reads the exit status of the recirc set, takes EOPNOTSUPP
(95, what set-dp returns when ovs_dp_change() rejects the recirc bit
under !IS_ENABLED(CONFIG_NET_TC_SKB_EXT)) as the reason to return
$ksft_skip, and fails the test on any other status.

You are also right about the fragment. tools/testing/selftests/net/
openvswitch/config selected neither CONFIG_NET_CLS_ACT nor
CONFIG_NET_TC_SKB_EXT, so a kernel built from it could never run that
round, and the claim that both rounds fail without the fix did not hold
for such a build. v2 adds both symbols. I built a kernel from the
fragment before the change and one from the fragment after it: the first
reports the skip with the test harness marking it SKIP, the second has
both symbols set and runs the round.

The Low one: ovs_dp_change() starts user_features at 0, so a set-dp
without --features cleared every bit, and a pid list sent without the
dispatch bit was ignored while the command still printed "updated". v2
reads the current features from the GET reply and sends those when
--features is left out, and the help text says so.
