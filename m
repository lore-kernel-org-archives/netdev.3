Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F113280035
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801002; cv=none; b=r49cjMYX+PtdWvOwwFY7oFc9fhNVl2cCVyP9VN4IlevZs0Hp05f0b63NcoX+CZWMBeMhl0KjH1DZCshbU6rIqISRssqS44NywQc5DbN9KfcnKkORQ1OYq9JDzTU7jHJHd+b8MaFzMVQHo3CDxkyNVvf/n3jwlfG8TT0cUZKUsQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801002; c=relaxed/simple;
	bh=O+O9qGLnrqDvc2xubZ3AYGL7tM5iV2XD3weKLXH+Iww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thQa+Wbg/XFIVYx3CMLwewFTH5x2mKUD/yMfPDyipJHO+dLcOhfT6ffxqipJx1duD9o4Ro82/X5fMPtvGlHPk9IHIcH2UNdMY4Yyn2Ofij43UM3FU7Oo+R25Uoxz3peECOOH635NV6+L9zcjxGbfhrfZPB9SC650D3fF0cuJ98c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNAEfAKL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNAEfAKL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784800999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rofaZmeQJQMf8RwVbu92X+vn3sa/x64lWtyD1CQYv4M=;
	b=iNAEfAKLxCA8qBEqgSYsG8fH+X9c6YjB23sAFLNdqmYrOYJt0qMNVbZsRkkEYLl9YAVhW5
	IPFS9AsUTkdbrBalB968qlQf/n33kiIE5Wg+8ExpsMbo5wnzD9GnPuy26vsshwKaVvY+TK
	jQTRjghIU7Ms/o15awbH9EQ5eUz4nRI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-opv3lHHgORKAoyCNESqhWQ-1; Thu,
 23 Jul 2026 06:03:17 -0400
X-MC-Unique: opv3lHHgORKAoyCNESqhWQ-1
X-Mimecast-MFC-AGG-ID: opv3lHHgORKAoyCNESqhWQ_1784800996
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26ACD195D033;
	Thu, 23 Jul 2026 10:03:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F068AD73;
	Thu, 23 Jul 2026 10:03:11 +0000 (UTC)
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
Subject: [PATCH net v4 0/9] rxrpc: Fix CHALLENGE packet handling
Date: Thu, 23 Jul 2026 11:02:56 +0100
Message-ID: <20260723100309.530157-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Here's a fix for AF_RXRPC's CHALLENGE packet handling, addressing an issue
raised by Sashiko[1], plus some miscellaneous fixes found in the process of
fixing this, plus a number of things raised by Sashiko[2][3][4].

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

 (5) Add a refcount to the user key payload.

 (6) Make the AFS filesystem generate per-server appdata keys.

 (7) Pass the appdata from AFS (or userspace) to rxrpc.

 (8) Change over to using the appdata key to supply the appdata.

 (9) Remove all the OOB stuff.

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

David Howells (9):
  rxrpc: Fix sendmsg to not return an error if last packet queued
  rxrpc: Fix packet encryption error handling
  rxrpc: Fix update of call->tx_pending without holding lock
  rxrpc: Fix generation of notifications after call completion
  keys: Add refcounting to user-defined key type payload
  afs: Create a server appdata key
  rxrpc: Pass appdata key to rxrpc_call and thence to rxrpc_bundle
  rxrpc: Fix CHALLENGE packet overqueuing and simplify RESPONSE
    generation
  rxrpc: Remove OOB challenge/response code

 fs/afs/cm_security.c         | 313 +++++++++++++---------------
 fs/afs/fs_probe.c            |   5 +
 fs/afs/internal.h            |  36 ++--
 fs/afs/main.c                |   1 -
 fs/afs/rxrpc.c               |  40 ++--
 fs/afs/server.c              |   2 +-
 include/keys/user-type.h     |   2 +
 include/net/af_rxrpc.h       |  21 +-
 include/trace/events/afs.h   |   1 +
 include/trace/events/rxrpc.h |   5 +-
 include/uapi/linux/rxrpc.h   |   6 +-
 net/dns_resolver/dns_key.c   |   1 +
 net/rxrpc/Makefile           |   1 -
 net/rxrpc/af_rxrpc.c         |  49 +----
 net/rxrpc/ar-internal.h      |  27 +--
 net/rxrpc/call_object.c      |   2 +
 net/rxrpc/call_state.c       |  57 +++++-
 net/rxrpc/conn_client.c      |   4 +
 net/rxrpc/conn_event.c       |  68 +-----
 net/rxrpc/insecure.c         |   7 -
 net/rxrpc/key.c              |  37 ++++
 net/rxrpc/oob.c              | 387 -----------------------------------
 net/rxrpc/proc.c             |   5 +-
 net/rxrpc/recvmsg.c          | 124 ++---------
 net/rxrpc/rxgk.c             | 138 ++++---------
 net/rxrpc/rxkad.c            |  27 ---
 net/rxrpc/sendmsg.c          | 124 ++++++++---
 net/rxrpc/server_key.c       |  40 ----
 security/keys/user_defined.c |  23 ++-
 29 files changed, 481 insertions(+), 1072 deletions(-)
 delete mode 100644 net/rxrpc/oob.c

