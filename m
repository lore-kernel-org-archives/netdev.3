Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0957E54707A
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790382349; cv=none; b=ZQU9xSuVVP2eIkVipLRn8TZXwxWTHtoFb3FULLeRjU7rs0Ka6rJ08dmLQZhBqCQBiPJmz/4xeW0hwHnuJIn2J9b9Lfi7Bw2no/DEwv/PEmHFg4oyE/+7fzZFkt1UwvAx+72ML11OK07VEwwWQPnt9I8yn+a3fTd/OTApuHmw1FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790382349; c=relaxed/simple;
	bh=9h2B0Dd2usVfbfRDWZYuQIvzRgz9vkuDx864Hr9H0hU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=alfsR9lwlOa7XgNmlJPcE63UP57hbfUthJ45R/PFmDdg40QKrNhFOeAkbSzrixGwGIJtdFzSl+N0FQNGn/hSiuUOK5KV8q50FCvQCykfH3dfjuBy/n/Pejg8O21wAJazTcksrcC9jHJwTkT0ZhJmnaDTFZUc0gPt21n/zVVMGe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=Frao1ska; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="Frao1ska"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a39a42dso448250b6e.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 17:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790382347; x=1790987147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=67f1Rgbr2rbEcl0AX4Xr06l+mGUzY4TIGIHJlMP430E=;
        b=Frao1skaiye1v3gtc6qVdnHkwd3oZs+4zK6nq2z5B+9a/xbJTppRqBVjFSEfHGjMEt
         GQOfUx8pbWHh5Ka9+C7BI9PapNffQPL/b++tVtsX0wwSWzz2IVILR5lN6URxqlmEJAQ8
         b+9YbzjHpa0PvoCWmECUuly3VSUA/JjMrXPI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790382347; x=1790987147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=67f1Rgbr2rbEcl0AX4Xr06l+mGUzY4TIGIHJlMP430E=;
        b=BrZsfG2easrZAX8VhcBau4YG/jo/LUP5sedoktaEaWBthTWSiEpOBBv7Ww8RETwzCP
         pyIhtU7IWebAfhaTwpAQB/HzJcgyakcc4Y7P2papw2wti/LWbxM41v29FbGtyu6XbPPR
         ijrTFVq/zna9/0sj2j7Xabjj1H6GDELyFtHF4FhKRQ8hUU/UHDv9mcRvUtwIs2F81u2H
         PEVcKs6ufBwvo0apKvTEfEsc6iVTowTcNKCnLcsnQxDdvGPVb0nVw0BiFMwzJYA5LjCA
         AVBt8lgtvg+TYlrf4kYWbqOjYISptbHSPaWjJKski2irUyEeCVTaXGl83V406HjHMw5K
         91lQ==
X-Gm-Message-State: AFuF++kcT9jVs9yevjnWUNksZ0wiixzu8HRX5uDMNl5dr7jI/7Zh7rjd
	dURAv3O/Qf+EAo1T5NexZI8HPg6fzZHyoi4p2L/zpCPTGxJkYQo4K/WKBZSWC5lb9BaBCFwQm2H
	03lNPGE4=
X-Gm-Gg: AYBFou2Pb+NuxG6olvG4Cb9LYBCZ7ofWvA9fYzh96hgdgCPjxw/dcag9/TowSau2M1P
	BP9xQXJ0/KOyBO59vubQQwwDG6HuswklQ8Q1tuxyZ5Do9dPqb+PI5j0UyMbzGdFH7qGTMeZ43y0
	iW4O4kqhU2orLn76FQEhZQU+/OVcTZsK5S7WhbbN8oG9xIFAr0nJUo4qYA2oAQTN4+OLjaZPPNq
	IChAfWaAOxwHyQ99L1bawfcsfYu4F8b7WGpNjT/rs80e0gsNnaAif/A2t9rXmxNJfobuDumyBQv
	ZovSdC6arHQytEkWw4PXsMdS6EhKuDBj7oufsmU56lJrHbB8fYMzIy/fqiGoWUueJl17Fji0i0Y
	GwNlyT/IEqHrP0HjsB1wv2DPLg3VK9ENEmyuhebbO6yElFPn6JEmIEmN7xR5/bHWPHrM2EhFLhw
	eJv0CEU1RfvMNLhNKZB+tTOYX5ElQLobWguQFt9bRwpIzHOBMRbKNbkNnCgfIR8LioZQvNV/lxj
	LAxXpevdWP+2EsfP0TuKhlKxgcuaks/FaYs0Svh4HCICiXeRIQLSfgh7XFlqRVJP5rg5KF/VBpW
	KlU=
X-Received: by 2002:a05:6808:2387:b0:4d6:9133:cff7 with SMTP id 5614622812f47-4d72d1655ebmr6181079b6e.30.1790382346849;
        Fri, 25 Sep 2026 17:25:46 -0700 (PDT)
Received: from com-68297.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4dbf6209b83sm3357499b6e.10.2026.09.25.17.25.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Sep 2026 17:25:46 -0700 (PDT)
From: nramaswamy@openai.com
To: netdev@vger.kernel.org
Cc: Neil Ramaswamy <nramaswamy@openai.com>
Subject: [PATCH net 0/2] tcp: preserve RACK tracking across partial undo
Date: Fri, 25 Sep 2026 17:25:21 -0700
Message-ID: <20260926002520.42955-4-nramaswamy@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neil Ramaswamy <nramaswamy@openai.com>

I've been investigating a bug in TCP where RACK loses track of segments
after partial undo happens. At a high-level, RACK can react to a SACK
by scanning its sorted transmission queue for segments that exceed its
RACK timeout, mark those segments as lost, and remove them from its
sorted queue. However, receiving an ACK with a TSecr less than the
first retansmission timestamp of the recovery episode can trigger
partial undo, which removes the lost flag from segments not yet
cumulatively ACK'd but does not ensure that they are in (or are added to)
the RACK transmission queue.

The symptom that I observe is that a long tail of hole segments can
"escape" RACK and then only get sent out by the retransmission timer,
which can take a long time and even be serial for many lost segments.

A conceptual example below illustrates this situation; I'm intentionally
excluding TSecrs/byte ranges/etc. when not relevant.

   TCP A                            TCP B
   
                             Assume TS.Recent = 200 to start.

    A, TSval = 210 --- <delayed>
    B, TSval = 211 --- <delayed>
    C, TSval = 212 ----------------> arrives
    D, TSval = 213 --- <lost>
    E, TSval = 214 ----------------> arrives
    
                   <---------------- SACK C + E, TSecr = 200
    A', TSval = 216 --- <delayed>
    B', TSval = 217 --------
    D marked lost           |
                            B' ----> arrives, ACK delayed
                    
                    original A ----> A fills leading gap,
                                     TS.Recent = 210
                                     
                   <---------------- ACK through C, SACK E, TSecr = 210
    retrans_out = 0
    210 < 216 permits partial undo
    D lost flag is cleared
    D remains absent from RACK list
    

A bit of commentary on this diagram:

1. The timestamps I'm using are for the purposes of showing the
   partial undo comparison; these aren't an exact schedule with the
   timeouts RACK would use. See the packetdrill for that.
2. A and B are also marked as lost and removed from the RACK list.
   However, PRR only allows A and B to be retransmitted. D
   being marked missing consists of being marked as lost and,
   critically, not being added to the RACK list.
3. I delayed the B' ACK because if it is sent back, this may let the
   sender retransmit D before partial undo happens.
4. At the end of our diagram, D can only be rescued with the
   retransmission timer.

There is also another more catastrophic situation in which partial undo
might happen when a stale TS.Recent is echo replied [1] when handling
out-of-order ACKs, and I've seen this cause the RTO to jump to over 100
seconds. But this combination should not happen if [1] is merged.

I see two options for fixing this, and I provided the first as a patch:

  1. When partial undo runs, we make sure that a segment whose lost flag
     is cleared is added back to the RACK list.
  2. RACK does not remove from the RACK transmission list until a segment
     is acknowledged; I think this is a bad approach because you would
     end up scanning already-marked-as-lost segments every time you do
     loss detection.

Without a fix as such, packet "D" in my included packetdrill takes around
400ms to be retransmitted via RTO. With the attached patch, D is
retransmitted within 50ms of the partial ACK, without an RTO.


[1] https://lore.kernel.org/all/20260921222609.50824-4-jeffjo@openai.com/

Neil Ramaswamy (2):
  tcp: restore RACK list membership when undoing loss
  selftests: net: packetdrill: test RACK after partial undo

 net/ipv4/tcp_input.c                          | 33 ++++++++++++
 ...tcp_partial_undo-restores-to-rack-list.pkt | 54 +++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_partial_undo-restores-to-rack-list.pkt

base-commit: 11536ee3d3e0b1bd35b6f3f8df55a6053eb0c71d
