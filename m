Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AD43AE1BC
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494427; cv=none; b=bQR5kXGgazMe4p+hh12rICK2jfi/DuzIJBDle/8J/zsUUaVINiYfN8PTrFzJUtA0biqQox3GAE/rjhpDY1F1Mqi+U+rVPv0V49B5Kg/vT37PGMwmphiknQ8nMXEMCKaAW8ADMQ5RGvCNN93ZLOyTJikciflo/U+lwaLrlxq5A+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494427; c=relaxed/simple;
	bh=ZmRkpa96nlrJCixWgwASI4DUbhP3Ms77eFQ2CQkARmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEUZOrH2YpuT1ErnhriI+CjJs+xKh6Cms2GG63PlrPgOlwomQQh8b3rLmkrq0M4dGZo19hNTXiN9uie0dr6WhMgebC//dVWuwe0vhD7fO1nAxUXRU4JVyq8XK/+NLGxGj2c37F5IuxQsUj81GtEDkcPh1ZPnYOLgX3ru6r/3JJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=RPu3hBrW; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="RPu3hBrW"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-825b40f8a26so1706836a34.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 14:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791494424; x=1792099224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EcuCJfZ9Fs3HAtWAzguUXStL6q8t6MptiYwiyeKGOkM=;
        b=RPu3hBrW407ubjSyb8jNZk609/4L1kJdimyhfh6WWwIpX/G5nhjtZbq0213qdU5qVu
         v3hdJN38E7B1rR0VVIBVoY5Qao6ii75ApKGxQ6bebVl9iBOqsOXOxHdopZbxjeTWVAZq
         xaoIMkMboQFXmhlhSijjNvgdfcE+sBnjsCMb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791494424; x=1792099224;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EcuCJfZ9Fs3HAtWAzguUXStL6q8t6MptiYwiyeKGOkM=;
        b=I7JZh0RkI7v0haxw31n282ubh7jcV480sgR8gIO+mAqc63SABPbpJp8mrzgzU+s7yj
         nfhAKqBLOayLmNlmsmC3Gcfxcx1xXPHrYRM1sSUE4EFWK3fAed91ckxxmnd/SeIwxMt5
         XJfvK6BSwmICRRaRlbZK4EwfmA8s8CzHIsU7KdSFvXut6L9xC2FVA/kg3mNIJ13bLLJG
         4jNFPy3TzcGWps/oATPQO1tYuUWCfEaEkBUIUi50eOE123D/Wt1kp/v+eFCg3C9BR7XR
         pidsD8y1fX8I0P/1PNZjkZjly602141HPtwVVnCbz0Bp4bjjfGLl5OS3pofb4N37muQF
         TT5A==
X-Forwarded-Encrypted: i=1; AKwUvBy4C4ApNpFYVl08+Rt7qy53EwJoqAakuIuJlmCgPgsVro91bGV0QsUag6+hyBOBSFS07s7ZvMM=@vger.kernel.org
X-Gm-Message-State: AFuF++mlUT5w1/no08xwW7Ipg+OPpt29fgFUlnFvPmCiDmMlm5Ima3Dy
	eJTQUL1PiJ3snoKHeZwncPPu2iZ5MDeAz82+G9WQrVllG71s+dcf3B4dmfN9a8+M64pSwnT7iGG
	s8g0y6IOimg==
X-Gm-Gg: AYBFou0+buNviqHyFIllcR7hYSDH6yIfd4F2BgOa7Dd8O/xmYvoGUktmXW2LU7Fa8cf
	230Ry+vYclVnyw3/P41Hw4AarwvX4P3YurHvakw+i/Nh7PEty5h8UvvZdK29xJ9KuK1vT9RWhtu
	S5VRxMiOW7SKgaYlDR6jc1LW85EtqET4YmsHNTMyVC+87n/EQCfvSmOeDjGuzm9l7N2C7TZ/x0h
	ST1jrHmUPqJSBjFeyD1RRq7P6BFvcVExxA7Zo5wYU9fyBUYcdzsMcunxqrXVfajaZ/lDVdnrOCu
	5sGm//3IgloVYWRWxX7M2JcrvGpnreAkgFmSQ2R/vUTxFDMV5ZlmyETQ1Hj2vDpaz4aCf9A2ga3
	bQtukI/dLUnegGER7LZH+3/BhK0FOEC9ODKr6veAlo8PXiZPcTa9U8/ZkWTKkorsUrnSDqE0snT
	vfG44Nass9/1zprRcx/snVJqwdJTOps1hgLANRfqNll4+4w90KwbwvoAekZG8wSXCpGAoCDZaBj
	LA2Ni2+uH/8YhlEltU3jGhH5y3fZCu+QvHFPzQQrSoa5KL6rtIFEifEq4GLcBJ7GaO8cowuHaF5
	86sB8P2jlSuugA==
X-Received: by 2002:a05:6830:6a14:b0:823:25c3:30a0 with SMTP id 46e09a7af769-82acfbb6d47mr8023946a34.18.1791494424614;
        Thu, 08 Oct 2026 14:20:24 -0700 (PDT)
Received: from com-68297.corp.openai.org ([199.47.143.0])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a328dccsm117624a34.22.2026.10.08.14.20.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 14:20:24 -0700 (PDT)
From: nramaswamy@openai.com
To: Neal Cardwell <ncardwell.sw@gmail.com>
Cc: Neil Ramaswamy <nramaswamy@openai.com>,
	edumazet@kernel.org,
	davem@davemloft.net,
	horms@kernel.org,
	jiayuan.chen@linux.dev,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	ycheng@google.com
Subject: Re: [PATCH net v2 1/2] tcp: restore RACK list membership when undoing loss
Date: Thu,  8 Oct 2026 14:20:01 -0700
Message-ID: <20261008212007.11619-1-nramaswamy@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006141300.1722466-1-ncardwell.sw@gmail.com>
References: <CAL4WiipKWgA-EcFWDQd3t7nBwU7AnkLvqs6j--he-dR-SAgqiw@mail.gmail.com> <20261006141300.1722466-1-ncardwell.sw@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Neil Ramaswamy <nramaswamy@openai.com>

Hi Neal and Eric,

Thanks for the detailed replies. Neal's approach is much cheaper than my
original patch on a few UML microbenchmarks that I ran.

I'm not entirely sure I understand Eric's usage of "often" when he mentioned
the O(1) list splice, but the metrics that I've collected from my particular
repro seem to suggest that Neal and Yuchung's assumption about LOST but not 
EVER_RETRANS segments holds in the cases I captured, so I'd be happy with that
approach.

(One super nit on the runtime complexity of it: in the comment for
tcp_tsorted_relink_skb we say that it's O(1) amortized time, but I think it's
more that during partial undo all relink calls together traverse the RACK list
at most once.)

For Neal's fix, I also did write up a small packetdrill that shows that segments
that are already retransmitted and then marked LOST are not added back to the
RACK list during partial undo, as intended. Happy to contribute that if useful
for explicitly documenting that this is behavior we are okay with.

How would you like to move forward here? Do you want me to fold this into a v3
patch with attribution tags or do you want to send a new patch yourself?

Neil
