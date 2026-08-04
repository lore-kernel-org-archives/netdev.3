Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FFB3A71BE
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864413; cv=none; b=EkvGxiyS84ntAxPs1ujN17Ydeiy/0sZGTD7iNgfQuVp4JMIJxdpPe3c9D3XJGt1/sD0OPQ0zvrJpnI1+9a4SECiyJg+n0qWY4UdF4bYS3Cg8jD5wjVkynk/jKUzN6y2xl6Nnlcb6HhVp/Z3y5C1K5cyGJp8BPATfORx9OIjzdwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864413; c=relaxed/simple;
	bh=0uqhMQyE+UNqTZB8XubmDnqA6643OAH8ynbg8mdFlyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WEAYOGlyPivaGvqWGNXlXU/xjID5cufi9F8w3nBzDEJy7xUbpbYGqRgOVUmJiFOPNZed0JQfhRTXm5aC/FIq5BiqJFeo+o2Uev6S3O/FkZGMujp9ctRN9vghwwj55nwl0YvOOyfHFGH4t+enC5LtQkI7/OT1wgQhobaRVQwj1yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0RvoBxN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0RvoBxN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785864409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZVVdpLbPijOVAO0NV+NyTUQqNPvqRD+JKNcUHNTML/c=;
	b=L0RvoBxNHMJ4OmXx1kMdazTNfZ8rDvMrPgW50umqjxjrb1kwSSkprfCHoz6ZbhGOe2zECn
	pAbB5rqA9JyQOLL99si8INhoIVCH3tcnBw8BMDhj1mqpcAenlPM6Im/Gdtn2UvtgtOVoSu
	hWD1G0rTL50py8ykcXkO7RtAmstxJbY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-hEpTE23uPPyq7LWikm7Eyg-1; Tue,
 04 Aug 2026 13:26:48 -0400
X-MC-Unique: hEpTE23uPPyq7LWikm7Eyg-1
X-Mimecast-MFC-AGG-ID: hEpTE23uPPyq7LWikm7Eyg_1785864406
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C242180034B;
	Tue,  4 Aug 2026 17:26:46 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.44])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 294B31956087;
	Tue,  4 Aug 2026 17:26:41 +0000 (UTC)
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
Subject: [PATCH net v6 00/10] rxrpc: Fix CHALLENGE packet handling
Date: Tue,  4 Aug 2026 18:26:27 +0100
Message-ID: <20260804172639.2844491-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Here's a fix for AF_RXRPC's CHALLENGE packet handling, addressing an issue
raised by Sashiko[1], plus some miscellaneous fixes found in the process of
fixing this, plus a number of things raised by Sashiko[2][3][4][5][6].

Firstly, the miscellaneous patches:

 (1) Fix rxrpc_sendmsg so that it doesn't return an error if it queued the
     last packet of a call.  After that point, the error will be returned
     by recvmsg() and returned it twice in two different places may
     complicate userspace cleaning up its own structures.

 (2) Fix error handling in rxrpc_send_data() for if ->secure_packet()
     returns an error.

 (3) Fix the update of call->pending in rxrpc_send_data() in paths when the
     call lock has been dropped.

 (4) Fix the generation of notifications from rxrpc after call completion.

And then there are the patches to fix CHALLENGE packet overqueuing and
simplify RESPONSE packet generation by pre-creating the RxGK application
data up front and passing it in a user key (thereby allowing userspace to
partake).  This is split into five patches:

 (5) Expand the abort trace enum to be larger than a signed char as the
     number of elements will exceed 128.

 (6) Add a refcount to the user key payload.

 (7) Make the AFS filesystem generate per-server appdata keys.

 (8) Pass the appdata from AFS (or userspace) to rxrpc.

 (9) Change over to using the appdata key to supply the appdata.

(10) Remove all the OOB stuff.

[!] Note that this entails a significant change in the UAPI for AF_RXRPC,
with the CMSG types and sockopt to support the OOB queuing being removed
and replaced with a new single CMSG type that conveys the user key ID.  I
don't think it likely anyone is using this outside of my kafs-utils
package.

This also involves a change to the user-defined key type, making the
payload refcounted so that it can be accessed and the length read, then a
buffer allocated that will hold it and other data, and then the content
copied.  The problem is that the user is perfectly at liberty to change the
content of a user-defined key (which will RCU-replace the content of the
key), so the length might change when we drop the RCU read lock in order to
allocate.  This could be got around by locking the key->rwsem sharedly, but
that might be able to deadlock part of the rxrpc protocol engine if memory
reclaim occurs.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

Changes
=======
ver #6)
- Rebased on latest net/main.
- Fixed more Sashiko-reported bugs[6]:
  - Fixed rxrpc_send_data() to redo the RXRPC_CALL_TX_ERROR and the
    RXRPC_CALL_TX_NO_MORE checks after having dropped the call mutex.
  - Altered rxrpc_send_data(), as discussed with Paulo Abeni, to rewind as
    much as possible on retryable crypto error (e.g. ENOMEM) rather than
    rewinding just one byte.
  - Fixed afs_make_call() to keep trying rxrpc_kernel_send_data() until the
    iterator is drained unless an error occurs.
  - Fixed afs_create_yfs_rxgk_cm_appdata() to use kfree_sensitive().
  - Removed remaining OOB trace constants.

ver #5)
- Rebased on latest net/main.
- Fixed more Sashiko-reported bugs[5]:
  - Removed dropped_lock from rxrpc_do_sendmsg() as it's now always false.
  - Fix rxrpc_send_data() to not leak a txbuf from the "maybe_error:" path
    by reattaching it to call->tx_pending.
  - Increased the size of the rxrpc_abort_reason enum value by removing the
    __mode(byte) specifier.

ver #4)
- Rebased on latest net/main.
- Split out non-relevant AFS patches.
- Allow logon-type key as well as user-type key as they're basically the
  same thing internally.
- Fixed more Sashiko-reported bugs[4]:
  - Fixed rxrpc_send_data() to wind the transmitted data back by 1 byte if
    ENOMEM is hit when encrypting the final packet so that the caller can
    retry.
  - Fixed afs_create_yfs_rxgk_cm_appdata() to add the 4 bytes for the level
    into toksize.
  - Changed bundle code to include the appdata key as part of the client
    connection bundle lookup criteria (don't share connections with
    different appdata keys).
  - Fixed rxrpc_sendmsg_cmsg() to allow only, not disallow user-type keys
    for RXRPC_RESPONSE_APPDATA.
  - Reversed the removal of the rejection of MSG_OOB passed to
    rxrpc_recvmsg().
  - Fixed rxgk_construct_response() to use xdr_object_len() to calculate
    the space needed for the appdata and also the space needed for the
    token and the authenticator.
  - Added a check into rxgk_respond_to_challenge() to make sure the key
    type is user or login before we access its payload.
  - Remove ->sendmsg_respond_to_challenge() too.

ver #3)
- Rebased on latest net/main.
  - Removed two obsoleted patches.

ver #2)
- Split the CHALLENGE/RESPONSE fix into smaller patches.
- Fixed more Sashiko-reported bugs[2][3]:
  - Added some more patches to fix some more bugs.
  - Get rid of the AFS_SERVER_FL_APPDATA flag and check the pointer to the
    appdata instead.
  - Rename the appdata key pointer in the AFS_SERVER to reflect this one is
    only for the YFS-RxGK security class.
  - Use barriers when reading or writing the server appdata key pointer.
  - Ignore the appdata for RxNULL, RxKAD and OpenAFS's RxGK for now.
  - Check that sendmsg() with RXRPC_RESPONSE_APPDATA is passed a user key.
  - Check that the appdata key's payload isn't NULL, for instance if it
    gets revoked.
  - Add some error path key_put()s in rxrpc_do_sendmsg().

[1] https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com
[2] https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com
[3] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260702144919.172295-1-dhowells%40redhat.com
[4] https://sashiko.dev/#/patchset/20260713081022.2186481-1-dhowells%40redhat.com
[5] https://sashiko.dev/#/patchset/20260723100309.530157-1-dhowells%40redhat.com
[6] https://sashiko.dev/#/patchset/20260729160108.2031453-1-dhowells%40redhat.com

David Howells (10):
  rxrpc: Fix sendmsg to not return an error if last packet queued
  rxrpc: Fix packet encryption error handling
  rxrpc: Fix update of call->tx_pending without holding lock
  rxrpc: Fix generation of notifications after call completion
  rxrpc: Expand abort trace enum
  keys: Add refcounting to user-defined key type payload
  afs: Create a server appdata key
  rxrpc: Pass appdata key to rxrpc_call and thence to rxrpc_bundle
  rxrpc: Fix CHALLENGE packet overqueuing and simplify RESPONSE
    generation
  rxrpc: Remove OOB challenge/response code

 fs/afs/cm_security.c         | 315 +++++++++++++---------------
 fs/afs/fs_probe.c            |   5 +
 fs/afs/internal.h            |  36 ++--
 fs/afs/main.c                |   1 -
 fs/afs/rxrpc.c               |  62 +++---
 fs/afs/server.c              |   2 +-
 include/keys/user-type.h     |   2 +
 include/net/af_rxrpc.h       |  21 +-
 include/trace/events/afs.h   |   1 +
 include/trace/events/rxrpc.h |  15 +-
 include/uapi/linux/rxrpc.h   |   6 +-
 net/dns_resolver/dns_key.c   |   1 +
 net/rxrpc/Makefile           |   1 -
 net/rxrpc/af_rxrpc.c         |  49 +----
 net/rxrpc/ar-internal.h      |  27 +--
 net/rxrpc/call_object.c      |   2 +
 net/rxrpc/call_state.c       |  57 +++++-
 net/rxrpc/conn_client.c      |   4 +
 net/rxrpc/conn_event.c       |  70 +------
 net/rxrpc/insecure.c         |   7 -
 net/rxrpc/key.c              |  37 ++++
 net/rxrpc/oob.c              | 387 -----------------------------------
 net/rxrpc/proc.c             |   5 +-
 net/rxrpc/recvmsg.c          | 124 ++---------
 net/rxrpc/rxgk.c             | 138 ++++---------
 net/rxrpc/rxkad.c            |  27 ---
 net/rxrpc/sendmsg.c          | 140 +++++++++----
 net/rxrpc/server_key.c       |  40 ----
 security/keys/user_defined.c |  23 ++-
 29 files changed, 506 insertions(+), 1099 deletions(-)
 delete mode 100644 net/rxrpc/oob.c

