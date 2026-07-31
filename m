Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A46288C81
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 03:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785468254; cv=none; b=KnCWizVaW8bG8GCCxe+ot3m92mYKWuFoECsFpC7pYlWGQc9pm4aJGWJ3TqYqx1UQUwXfwUmwi8/aIGBb+tl0orcM/bw6uBJdLMNqdfbLXNILSA3GXzBXebMawMue/HvrJLzA80jCnCZ3v1V0ZaCl5P7hC6ZEEfp6bLPH4arXHV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785468254; c=relaxed/simple;
	bh=TM6yUSd86T9c7CJH0RLQPcEvuqoCm5mVdibybM7ldkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mO3VBv7xB6UNQ2xUGmK97CB3+pMNTxp54Mf5RkbDdlTvHhrss/eiZvTeWiulL51SPMx2G+FJeGAX5rtzC3xwrz6rOVhY6MvlEKUySGREd9u0q6hFtsfPtogUp8QGpELU6S8jwmvMUHgoVHC78mjT9MpQ45Qf1NIE8jhyBO2Qqgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIZo1B0M; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIZo1B0M"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cacb8416a1so5076175ad.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 20:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785468252; x=1786073052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cGFm3V3bJXmwLL5Y2WlirnWL5iEhwpm4whM/A9IFBpw=;
        b=dIZo1B0MwFF5HY6ddBWNgvcSlISARzNZmTze+vt/1EFlA1c6YbWwSrb84nJzQoYcQ/
         zb3o4btck9J+b29w0wNtDGscSeU3Et0WYwbL9gnmB0gzvZgP+a2a+eZ4MAKFsIDnikDX
         dmN0ef9q1EZFb2NTOctCgF3PKoeTQuesthI+alWefXXU+/84bdDRqv3TD/ntA+gYWtTQ
         HHm2okYJVIBRszUvU+NCcJqSUq+j8HFeZ4yZ9gFv0xqq68juBLsKNseq8I7g3ka5V7Dx
         2VtXCKUSuiAv5RHePN64/YFgP54IPWDWYLqLEhv16BlXS8oDMGMI8GqOlAWmcFzIcWAO
         TGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785468252; x=1786073052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cGFm3V3bJXmwLL5Y2WlirnWL5iEhwpm4whM/A9IFBpw=;
        b=qFwpniYlwXWrelbzMprA26aoaqNb5OpnU8CpB8TTiiwxBb6UtRm7QBJtO3Mrmchkiv
         DibI9s687yCccD51qDEGpO3DpC6BoB+a2Ps2bZ68/9rRcBFTTbma2xjVX2w63vWryBRI
         dVGE/hgauHRFqD02karNvhuZqvJMkbKO3XYC8m/qJw1QwOx9PNOkN+Ze41DulVzRPiQf
         fmAP+GdS2X5jRS8fKBFYMy20fHj+E9EqllvuZaF0cQUytpxFvkUsfdDNVv2IqN/DncXl
         KYKScAiAeMEpScf7LmUHLevrLbNhStlQiKCSwJbBQdBaw62buBA/nTMPEHTQoi0I1orV
         utJw==
X-Gm-Message-State: AOJu0YwyM40N8T9YzIgBeuME9xBkQyZwZwD/YI5og0kEj5E12fMQhua8
	h/wH43kcImqmOwnDk4jSn6aqsaLLRRBEq9r088qMNfw3ukx6Lu6bPXDWixM7sJiGzaM=
X-Gm-Gg: AR+sD13d4pybwi84FMDVUzsBawO8dLGlE0hc33OXIX2xitD04x05oW8AaUYwehtQn18
	07F4wgyFNU1pBv+GtPkJ8vXn209ydBqCvw9Knnn1lvyEjoBTSvZ6HYdzPhgHJHup4AEg/3EiRcW
	8BWj8xqTSxCsDu9gXwg2EMKCKzwEMMfENLz1b0IRvxIo9jD3EOQ/8Klo20rVqTmrHl2qsaR37yv
	aUuMAn70g4KaWycX5MCLOjU9d7yVbVIrHR2ORSG+JOKBMZ93trIfYFBbDsfMPO+8T/fUQyRC9uJ
	kNBVV/z8tGdnhiOuZJS1ro9htralm6MgzGS9Uc8ZVqZewVJ4BwzLP1NiJY9gPj+kubMboxvpSlI
	EYVckspjG1Pe0y+/cpFr2/z1g/VYBubYz6wxt1QanOrTSZiQ9cQJMEajkT3lH926gEgLD918zMu
	fw8KznrLY6daRybVAxcJdhMji+5xjC5R3Cygm3IqoGrqeVguD1GY4wi4NNe8gMSlqMt4edO8Igx
	G713b2+yl3/urWwSobqSUpkFARuTrNIfPlkN6SJA+e3v8Yv
X-Received: by 2002:a17:903:3b86:b0:2cf:9344:b80c with SMTP id d9443c01a7336-2d046dab155mr4904345ad.18.1785468251543;
        Thu, 30 Jul 2026 20:24:11 -0700 (PDT)
Received: from localhost.localdomain ([202.8.105.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d047c42b4bsm869275ad.78.2026.07.30.20.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 20:24:11 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>,
	maciej.fijalkowski@intel.com
Subject: [PATCH net v2 0/2] Fix skb length accounting after XDP frag adjustment
Date: Thu, 30 Jul 2026 20:23:55 -0700
Message-ID: <20260731032357.6114-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes skb length accounting after XDP fragment adjustment in
generic XDP and veth.

v1:
https://lore.kernel.org/bpf/20260727032535.13469-1-sun.jian.kdev@gmail.com/

Changes in v2:
- Move the veth fragment accounting before the linear tail adjustment, so
  __skb_put() observes a linear skb after a shrink removes all fragments.
- Fold the skb->len update into the xdp_buff_has_frags() branch, as suggested
  by Lorenzo Bianconi.
- Clarify why the old data_len contribution must be removed before adding the
  updated one, as requested by Maciej Fijalkowski.

Sun Jian (2):
  net: fix skb length accounting after generic XDP frag adjustment
  veth: fix skb length accounting after XDP frag adjustment

 drivers/net/veth.c | 23 +++++++++++++++--------
 net/core/dev.c     | 10 +++++++---
 2 files changed, 22 insertions(+), 11 deletions(-)

Range-diff against v1:
1:  b914fb40f348 ! 1:  2d716a1bd570 net: fix skb length accounting after generic XDP frag adjustment
    @@ Commit message
     
         Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
         Cc: stable@vger.kernel.org
    -    Link: https://lore.kernel.org/r/20260720141859.19FF41F000E9@smtp.kernel.org
         Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
         Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
     
    @@ net/core/dev.c: u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buf
      
      	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
     -	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
    -+	 * (e.g. bpf_xdp_adjust_tail), update skb length fields here.
    ++	 * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribution
    ++	 * from skb->len before updating data_len, then add the new one back.
      	 */
    +-	if (xdp_buff_has_frags(xdp))
     +	skb->len -= skb->data_len;
    - 	if (xdp_buff_has_frags(xdp))
    ++	if (xdp_buff_has_frags(xdp)) {
      		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
    - 	else
    +-	else
    ++		skb->len += skb->data_len;
    ++	} else {
      		skb->data_len = 0;
    -+	skb->len += skb->data_len;
    ++	}
      
      	/* check if XDP changed eth hdr such SKB needs update */
      	eth = (struct ethhdr *)xdp->data;
2:  59c79966c84a ! 2:  e5b9383bc46e veth: fix skb length accounting after XDP frag adjustment
    @@ Commit message
         Subtract the old data_len before replacing it and add the new data_len
         afterwards, keeping skb->len and skb->data_len synchronized.
     
    +    The fragment accounting must run before the linear tail adjustment:
    +    when bpf_xdp_adjust_tail() shrinks the packet into the linear area it
    +    releases all fragments, and __skb_put() requires skb->data_len == 0
    +    by that point.
    +
         A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened by
         1024 bytes from its fragment area. Before the fix, all 10 runs produced
         corrupted payloads. After the fix, all 10 runs matched the expected
    @@ Commit message
     
         Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept non-linear skb")
         Cc: stable@vger.kernel.org
    -    Link: https://lore.kernel.org/r/20260720141859.19FF41F000E9@smtp.kernel.org
         Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
         Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
     
      ## drivers/net/veth.c ##
     @@ drivers/net/veth.c: static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
    - 		__skb_put(skb, off); /* positive on grow, negative on shrink */
      
    + 	skb_reset_mac_header(skb);
    + 
    +-	/* check if bpf_xdp_adjust_tail was used */
    +-	off = xdp->data_end - orig_data_end;
    +-	if (off != 0)
    +-		__skb_put(skb, off); /* positive on grow, negative on shrink */
    +-
      	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
     -	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
    -+	 * (e.g. bpf_xdp_adjust_tail), update skb length fields here.
    ++	 * (e.g. bpf_xdp_adjust_tail). Remove the old fragment contribution
    ++	 * from skb->len before updating data_len, then add the new one back.
    ++	 * This must precede the linear tail adjustment below: a changed
    ++	 * data_end implies that no fragments remain, and __skb_put() requires
    ++	 * a linear skb.
      	 */
    +-	if (xdp_buff_has_frags(xdp))
     +	skb->len -= skb->data_len;
    - 	if (xdp_buff_has_frags(xdp))
    ++	if (xdp_buff_has_frags(xdp)) {
      		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
    - 	else
    +-	else
    ++		skb->len += skb->data_len;
    ++	} else {
      		skb->data_len = 0;
    -+	skb->len += skb->data_len;
    ++	}
    ++
    ++	/* check if bpf_xdp_adjust_tail was used */
    ++	off = xdp->data_end - orig_data_end;
    ++	if (off != 0)
    ++		__skb_put(skb, off); /* positive on grow, negative on shrink */
      
      	skb->protocol = eth_type_trans(skb, rq->dev);
      

base-commit: 97ac08560d236ca17f6606d9e671118e5eae5721
-- 
2.43.0

