Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309813;
	b=uYbEB8z6ye/6m2WmprrQeE4gByIh/DMI44j2IfMwbpujxJa0iS3d7c3xI5ZejvKoSK90
	 0iEDbLppvM6mNnb4lJ+sVqD8iP8gfoB8Uf4Dr4CaUgXXvaKtNf9m6/yAEKTVUHNklMDxU
	 QgMEFbXXl6W7SdDP1s/tMwYWp4qJSOPGtBUPkUw6JpRCJl3ZYPR6X1G3DtFt/hbvGhTTM
	 1TJAM/RmdR1K4Nb0sdF79jozvhO3L6BkNXi0uDw+lNocTD13F4yKtwGdTO4M1Ad/VoEWd
	 9vs/nsJnUWgv4WDhCOx5meKBwOJBzhXEd4QFI1NXFsyZzH+WvNMAbrFhBxfyvy5/moA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309813;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DGq51QJrQsvY2v7g8/tGIwgu4Arc6xoOnd1DO44Z1Sk=;
	b=YU9kH+eJP49Ar32aBczLKc2aDmxhlzSWCUBDk2CpQOQ78JbY16RehT0C6rXXaDVA5LJq
	 JGHmMr/q1PsGK/tc1D8ijMaHZeeyzGlcDMpuH6lnDgTBWYHbRR5F4psnhTr/OsyRpiMKG
	 8IP3S/WU8gEzNt4AABMClYVHTr4S05aCY9iSv1Bqsr/S1+m1pViPjCXo7Py8x99bIeXyF
	 Sgm4NUhMGXWgVYxwzOqi5GXxFkNIul2gPQfeJzI18XQQlzE+TCoRGIr81cXRyRMC5bo8g
	 /00EUslxe0JeRA3LQgnYVqS+wfEV7chfB658pWCDjHC25KddfYHH/+LjJVMzWL66F3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a0zmvyTZ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rRbconzt;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9172C606A332
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 11:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9172C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a0zmvyTZ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rRbconzt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794309810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DGq51QJrQsvY2v7g8/tGIwgu4Arc6xoOnd1DO44Z1Sk=;
	b=a0zmvyTZsoR6lst4JJ3XE6hF+X6ne/wLk677jvnTXjWXNTDFrmQkPi3xHZ9hRogNrgDwCt
	8L07Vx/0fkdjyIjMXjA8WC09YNBPtNdQEgbPCK6ub3bdFWEVl6Xa8EShO2M2f9e7e/c27O
	i9IZDIDCPhxEKlcHwqc7rHKY1klHZlI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-cslP_1lnPcG-DrKyS--6sQ-1; Tue, 10 Nov 2026 06:23:29 -0500
X-MC-Unique: cslP_1lnPcG-DrKyS--6sQ-1
X-Mimecast-MFC-AGG-ID: cslP_1lnPcG-DrKyS--6sQ_1794309809
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-536778a8137so37059231cf.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794309809; x=1794914609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DGq51QJrQsvY2v7g8/tGIwgu4Arc6xoOnd1DO44Z1Sk=;
        b=rRbconztkoMxAoXmr4b7yOde5UMlxpUrCIZ8miBpo06PV6TzgX2Ti1KnoJc2v522p8
         pgHcFvc1Sdd1wwV2QavbJiabwXZz1mwjpIVec/vLo8L+2f4+X3ZI98kPazV/sxIdXpLP
         h/Uuk4cIqIs47O6XdZ6ucwPllMwPL0tHnznLg5AswNggzhgBq2Zbp9S3L8hBxgeeJ62h
         QTbAHwafZe0qNdqsCPl/9EZbALFHBeqxhvaDH0xyAUkeNjl51rbgCZYy5cJYps+EVMhH
         +KbtG6Xnp08J6LqvaRw8SK86J4DyLRc6HQ0wtxY5t6emuvveAM3n270esFEm8pG+0FeJ
         OLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794309809; x=1794914609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DGq51QJrQsvY2v7g8/tGIwgu4Arc6xoOnd1DO44Z1Sk=;
        b=TyMqpQlD+6AlZfl7oaqTdOX4VhwDDjlgctDUAYPJZ8W3lXsHMw6x73nuqkTgyxsvVb
         p4vr/EYPn9YzDaAi/Vf/nBB5FTgLKUC9dvTrVvYz1gPngWzA+m0j73Et8eSVVvt1rJnT
         HVWlT/rktyPu/QiDiNH3BPAif2mRyY/x+IahgrDBIF6ciBFjuLyk/QNoY9uI3SDu7wxY
         oZTP970GdnqlJR6FMgxXw7nKPaxlKfqmuXFxZ/RZRIuEZI4vZ48y3GzUChseZHsu/Uhd
         Ze3MMEIqbwueon62cxp1ONOcDif5NakNy2mLjYOZBerL0QSTRE0eXpMZCQQVYdSTjV/9
         9xhA==
X-Forwarded-Encrypted: i=1; AL+hErHaUc/512G+fpWDlkYUZGYPN5vRHY+1WIidLnmmpEgaB5De9Uu8tZOww1wiBGM2xZLcSwW0MBc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qJi5wDgVnfDOcJTipH6ifO9BOh+egnTazYBGCG2flWkV9eAyh
	tlrl+8PpFu9a08AW+jOq6gnM2151LrWq1pobjys5VK0pDoFndPZkquldbTH/CrFsFqvMNGtLXFL
	jiQrbqWipDIOj/TQQiQ9BkqiFKpSj+QAAtz5JAlrZFH0Qv7GaZTQLob7yMQ==
X-Gm-Gg: AYBFou2csvrZiFgqBpppzuM3D6ofPM00rExmiEN6nhIhfyxgFwWGXeysc85+TxzWQzD
	QV28ho5hv94KKr4UrxKJO3ptiL3Vp5R0Do8I4BLkcZI0X4eWAZijqHXfLguwD8v0gfwxIU98+cQ
	iDx8JZsTa1t3ogOibHOksskfVOidcBvBukezC4QMBh2LNjSDeo94qw8eh/4R0SGYSg/e55i9bfx
	K95uQQY5j7CY3v269eUd2bdfxIroK3XnzFSvGp6zXJwXjsE5VgUfmgCFMMBacOnUT3RXaYdIaGg
	+p1yJtPmizq3r1SGcZClO5EPWsG4HiCX0sb7t2636XIgTZLGkD2BCGgJKAgWnh4nuHt3zio8PlN
	nq6UREinmgqFcxqNzoVaS0nwb3FRG1rt4idZyyL3h+4lh8MsRmfX18oaXUtvgXhmMQtkoknqlWg
	DKs8f2CPtf1LeryHNEywr7WQOAn8vh3YNUPih64HGPZ/ysrSjtv45hlzvDowCg8aF1ELO350ldY
	/Kj0T4zcnplnyGgoM7Q/fdAj9MRyWTHFiVqltNZZ6FSvO4BEqaS
X-Received: by 2002:ac8:6103:0:b0:537:636f:b31 with SMTP id d75a77b69052e-5552a45df54mr30141121cf.73.1794309808547;
        Tue, 10 Nov 2026 03:23:28 -0800 (PST)
X-Received: by 2002:ac8:6103:0:b0:537:636f:b31 with SMTP id d75a77b69052e-5552a45df54mr30140831cf.73.1794309808077;
        Tue, 10 Nov 2026 03:23:28 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04e7315sm18569186d6.22.2026.11.10.03.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:23:27 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 0/4] net: streamline skb_splice_from_iter()
Date: Tue, 10 Nov 2026 11:23:21 +0000
Message-Id: <20261110112325.3263078-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
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

skb_splice_from_iter() does per-page work even when the input describes a
contiguous range of a larger folio. Adjacent tail pages have different page
pointers, so appending them separately also prevents fragment coalescing.
For ITER_BVEC, the helper first builds a page array, then walks it to append
the bytes that the original bvecs already described.

This series removes that redundant work from the MSG_SPLICE_PAGES path
used by sendfile(), splice() and other in-kernel socket senders. Contiguous
folio ranges become fewer skb fragments, with fewer page-reference
operations; BVEC input is consumed directly, without the temporary array.

The patches separate a correctness fix from the optimizations:

  1. Make a zero-byte request a no-op and restore the unappended iterator
     remainder after rejection, preserving any successfully appended prefix.
  2. Group contiguous bytes of a direct-mapped folio, including across
     extraction batches and repeated calls. Representation-safe anchors
     and wide endpoint arithmetic keep offsets and lengths well-defined.
  3. Walk ITER_BVEC segments directly and advance only by appended bytes.
     Bound the request against the unsigned iterator count before assigning
     the result to the signed return type.
  4. Add two KUnit cases for append/resume and zero-length/rejection
     progress, on both the extraction path and the direct BVEC walk.

Grouping stays within a folio and preserves the append helper's ownership
checks. CONFIG_HIGHMEM retains actual-page, in-page-offset, page-bounded
fragments. Software checksum traversal remains page-aware. The caller's
byte-count and partial-progress interface is unchanged.

Performance
-----------

An alternating A/B of the folio-grouping and direct-BVEC implementation
showed lower sender CPU cost for sendfile() from large folios:

  sendfile() workload                         change in sender CPU/GB
  64 KiB folios, 64 KiB transfers, full speed          -11%
  64 KiB folios, 64 KiB transfers, paced at 1 GB/s      -5%
  4 KiB folios, tested transfer/rate combinations      -3% to +3%

At 64 KiB, large-folio sends used about 2 fragments per skb instead of
about 16. Single-page folios retained the per-page layout, providing a
control for the optimization. The large-folio 256 KiB CPU result was within
run-to-run variation, rather than a resolved improvement.

The measurements used a Linux 7.3-rc6-based evaluation kernel (532788178)
and virtio-net VMs, with interrupts pinned to NUMA node 0. Each
cell had four runs per kernel in alternating rounds. CPU/GB is whole-host
sender CPU time, total minus idle, per GB sent; received data was verified.
These measurements cover the earlier implementation of the optimizations.
The present revision adds iterator and representation corner-case fixes
and the regression coverage described below.

Testing
-------

The mailed tests are two KUnit cases, not a broad ownership or coordinate
matrix. Each runs through both the extraction path and the direct BVEC
walk. One appends part of a multi-page folio and resumes: payload,
checksum, fragment count, iterator residual and ordinary references.
The other checks a zero-length no-op and rejected-page rollback with and
without an accepted prefix.

Those cases passed on UML, with no skips. The focused build used W=1 and
WERROR=y. The mails apply to the stated base and match the recorded
intermediate trees. This is not a KASAN run, a physical-NIC test, or a
rerun of the measurement above.

Together, the measured reduction in fragments and sender CPU cost, the
single-page-folio control, and the progress regressions support making
this a generic improvement to skb_splice_from_iter().

Thanks,
Alex Markuze

Alex Markuze (4):
  net: preserve splice iterator progress on rejection
  net: skb_splice_from_iter(): group consecutive pages of a folio
  net: skb_splice_from_iter(): walk ITER_BVEC segments directly
  net: add basic splice KUnit tests

 include/linux/skbuff.h   |   3 +-
 net/core/net_test.c      | 170 +++++++++++++++++++++++++++++++++++++++++++++++
 net/core/skbuff.c        | 141 ++++++++++++++++++++++++++++++++++++---
 net/core/skbuff_splice.h |  34 ++++++++++
 4 files changed, 338 insertions(+), 10 deletions(-)
 create mode 100644 net/core/skbuff_splice.h

base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d

