Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D3D342CA2
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697156; cv=none; b=nsTF42L+BcTwAibbfcBFvrEYHWq5BrzXwDCiM5K/VZSBsJi34hefXmmSpeO7UEqPwetyamwspnFtd61I6c2z/SoC/GPUMfVTsE3x7pNZDjx4sDPLAGOgC30vwnqv14+HebK8lfY0KEuEmDcwlO4TmRmcf4KYb2OcOnum/QVi0ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697156; c=relaxed/simple;
	bh=Y+Oe87Y+zq0e3lz5Kxtmiy1IL3ue+vz7+oEmEOdW/ag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jK52Jtwna5Y1KgN3KiaHkwKTAoctXseueKwX3PqgsgwANNzrrHYSNNJJ/iOPIsyM/ytku7wYy9T7MTkwlsE6CTQpuF5nMI7A8St189w72AcClKOzaD3yEBIQCij3f4T1cRVEMropbLQ61ZAD27oMOvq/PdwflkBLxi7eXuU9SAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q+fDmffd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q+fDmffd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776697154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gHUlnJZiu3wn1UaLU2mhPT1/9a82z63/7+nsN1lzlyo=;
	b=Q+fDmffdRy2WDjWu3Pi1bG6TPwNBjX7R9KYRBx/ObsQ7Q/kXq0cAieBaNT/FpaxxJsobFm
	pWrUrd/xaKO/+N6suA9OsCY2nq5g/BbNMKgDvL2m1/PQeipZFWRvLC8rdEq2CndH3h8cjf
	wfxagIRiu7GbaSsQC0XNLTIbYOhRk00=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-FVz965EOPDasHEmWto0xEQ-1; Mon,
 20 Apr 2026 10:59:11 -0400
X-MC-Unique: FVz965EOPDasHEmWto0xEQ-1
X-Mimecast-MFC-AGG-ID: FVz965EOPDasHEmWto0xEQ_1776697148
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33F17195609F;
	Mon, 20 Apr 2026 14:59:08 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4EB1F1800347;
	Mon, 20 Apr 2026 14:59:04 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/4] rxrpc: Miscellaneous fixes
Date: Mon, 20 Apr 2026 15:58:53 +0100
Message-ID: <20260420145900.1223732-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Here are some fixes for rxrpc, as found by Sashiko[1]:

 (1) Fix leaks in rxkad_verify_response().

 (2) Fix lack of unsharing of RESPONSE packets.

 (3) Fix integer overflow in RxGK ticket length check.

 (4) Fix handling of rxkad-encrypted packets with crypto-misaligned
     lengths.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

Link: https://sashiko.dev/#/patchset/20260408121252.2249051-1-dhowells%40redhat.com [1]

David Howells (4):
  rxrpc: Fix memory leaks in rxkad_verify_response()
  rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
  rxgk: Fix potential integer overflow in length check
  rxrpc: Fix rxkad crypto unalignment handling

 include/linux/key.h          |   2 +
 include/trace/events/rxrpc.h |   1 +
 net/rxrpc/ar-internal.h      |   2 +-
 net/rxrpc/conn_event.c       |  12 ++-
 net/rxrpc/io_thread.c        |  15 +---
 net/rxrpc/rxgk_app.c         |   2 +-
 net/rxrpc/rxgk_common.h      |   1 +
 net/rxrpc/rxkad.c            | 142 +++++++++++++----------------------
 net/rxrpc/skbuff.c           |  26 ++++++-
 9 files changed, 94 insertions(+), 109 deletions(-)

