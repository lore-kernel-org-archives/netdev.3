Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527193;
	b=EyZDCkJ8z2CKqKXWMD72bqGQZlDeaWRp3Dxi1tF8/I49a3Y94OCXE6Fo8Dw2Hun8Io3c
	 hC+qfa/wObd9XAOJRdvRPKK/Scw/jU5F/ySUZVfR4XspRdcm1Ne8YKDZYb2NsHISC2btB
	 E58Ffh+GEoKiIhuYj47ynLZs40Hzfbw5uNxRQAQJrc7xBOuL7t++3PP8uBUe90ZUR5sDi
	 sfudxIE20u2ZXiE3oEP3okgER9XCBqAmT829ctmfoKa7+Wi8fUcoHYGKU0PuuDwixl6r2
	 ISfVzsXIq+L7BrhRkbSiELul6iZaDof+6s1M+gOw/OSGFHvGvvidoSZmSqeRk9dyoUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527193;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=Oah3iaTrovgfL9AhWMbpu28y1JJA5jwM7jXNU1H/0Iw=;
	b=qyGzCbp2O5TBkeTQwxbmaGCFt5/s8J6vq9KRaPxdbhYyDCd3By23ALlhc9MW2OTrfvGN
	 YH5Z6qJrEYEQtv+99Y6Qw0sFLtfpXX0UfriAj8MjQ+PZEb9ufjzg9xsGPbBtO9tL9ujn6
	 2NIwT284Hlv8HADf7LI/oB81ioi0MI22JCLcMpaPHHF/wjC/E6sH98nWrY49cphXrS7wG
	 WizRISUSVQtGGfkceTcv4oIEKpoQk0otjgLaumbzslowN11iZkl4KhHA2BqQuMio/VRDp
	 KyFaNZuu6iut9s2S7PNqXBc5tbiodLVnB6oMzQEKvpDB8vEtFno/LX91iDqGibldpVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vi3Kc5n6;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49A7606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B49A7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vi3Kc5n6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792527191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Oah3iaTrovgfL9AhWMbpu28y1JJA5jwM7jXNU1H/0Iw=;
	b=Vi3Kc5n6jLN34G8bsLv4v1GpOHmp5SHb3I3Id2qpM8pWoDiR64VqJOeeeZ9o9OspqDF/GO
	su/WUxK1yLyosc+CHthZuBV98o2HWP6vdZtpBiFMSDdsjQtEXo750ECC5pVOQ5SGXkPAMG
	LdFBcInye24mtoLy23pnD83yvmc5QAk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-JJguI9unOi-Q7vdkgp_c0Q-1; Tue,
 20 Oct 2026 16:13:10 -0400
X-MC-Unique: JJguI9unOi-Q7vdkgp_c0Q-1
X-Mimecast-MFC-AGG-ID: JJguI9unOi-Q7vdkgp_c0Q_1792527188
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF03E1954185;
	Tue, 20 Oct 2026 20:13:07 +0000 (UTC)
Received: from warthog.com (unknown [10.44.48.29])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C8027195608B;
	Tue, 20 Oct 2026 20:13:03 +0000 (UTC)
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
Subject: [PATCH net v2 0/3] rxrpc: RACK-TLP fixes
Date: Tue, 20 Oct 2026 21:12:51 +0100
Message-ID: <20261020201258.290827-1-dhowells@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Here are some fixes for AF_RXRPC's RACK-TLP implementation.  It's split
into three patches: the first just fixes the RFC number in comments but has
no actual code changes; the second introduces a new way to count in-flight
packets; the third does the actual fixing, including:

 - Making the "in fast/RTO recovery" flag available to RACK-TLP code after
   the Reorder timer expires.

 - Arming the RTO timer if no other timer is running and there is unacked
   data.

 - Initialising the TLP state in the correct place.

 - Not resetting the xmit timestamp when marking a packet lost.

 - Correctly checking the flight size.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes-2

Changes
=======
ver #2)
- Rebased on latest net-next/main.
- Fixed Sashiko-reported bugs[1]:
  - When performing TLP_send_probe() [rfc8985 7.3], don't do backoff.  Note
    that backoff may already have been done by rxrpc_resend().
  - In rxrpc_tlp_calc_pto(), clamp call->peer->pmtud_jumbo to be at least
    1.
  - Added a patch to replace the way in which the number of in-flight
    packets is tracked to avoid estimating using values which aren't all
    updated at the same time.

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925191520.2206700-1-dhowells%40redhat.com

David Howells (3):
  rxrpc: Fix the comments saying RFC8958 to be RFC8985
  rxrpc: Fix counting of in-flight transmitted packets
  rxrpc: Fix RACK-TLP implementation

 include/trace/events/rxrpc.h | 11 ++++-----
 net/rxrpc/ar-internal.h      | 22 ++++--------------
 net/rxrpc/call_event.c       | 13 +++++++++++
 net/rxrpc/input.c            | 15 ++++++------
 net/rxrpc/input_rack.c       | 45 +++++++++++++++++++-----------------
 net/rxrpc/output.c           |  5 ++--
 6 files changed, 56 insertions(+), 55 deletions(-)

