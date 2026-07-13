Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2550B3B42EE
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783930306; cv=none; b=a2uPCy1M4P+S50qxItXtbragmp+kgCx8dpiDnhU4+ELqGTM/yS1nJjs95Ha9pGgthNdjfHgVPvPSfzvcDkWwQtROyvgIpN+WyJPP/LP2LEsmMBinhuLlwCORKTd3IVPU943T8jJMD0Ad3/7/ou+Pp1L4opH2R/t/8nJnNF8yQtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783930306; c=relaxed/simple;
	bh=wxeLJD1UzjGXLbnoWGwYeLTrd2eBGobtOf88dwGjJCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YiolYd9o5dgdDtkYiqX0Op+3JWfIua1SErbL0LFvp5ZtzqsywNYDEybudNag/MZghX4mph18OD1re2SpdDCNBWLX8qssJbsYv7Mj1R2xhBrnt64iqbiba6PNlOMWF74qEGdqkwNCQ0IqlDdtwDO6WcwtnW7N9W1oJctvCQeJgto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gs3NGL9O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gs3NGL9O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783930304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VdaFEwp32dDtXPcdwIOFGZNO2w1ickfbhxsVue5EZN8=;
	b=Gs3NGL9OmGSfu3XNe+QiWrMqNtUTpmEBdOYQw8mBRUGDZLXuEBn1ZqxOk1NzBmGyWGsDLe
	QjXUPx22GyUq7gFVKlltX2xh3xzPsHt5z0IBg0GZtEv5XdHIpfMn+uA4E6CCA2wPZ5BF4C
	H+Rocmyry9JwA8SCmiHJ9v4UwEYvSU8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125--iVFQNG3OUmOSge9CgyD4w-1; Mon,
 13 Jul 2026 04:10:31 -0400
X-MC-Unique: -iVFQNG3OUmOSge9CgyD4w-1
X-Mimecast-MFC-AGG-ID: -iVFQNG3OUmOSge9CgyD4w_1783930229
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DF441800658;
	Mon, 13 Jul 2026 08:10:29 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E3DF180028B;
	Mon, 13 Jul 2026 08:10:25 +0000 (UTC)
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
Subject: [PATCH net v3 00/14] rxrpc: Fix CHALLENGE packet handling
Date: Mon, 13 Jul 2026 09:10:06 +0100
Message-ID: <20260713081022.2186481-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Here's a fix for AF_RXRPC's CHALLENGE packet handling, addressing an issue
raised by Sashiko[1], plus some miscellaneous fixes found in the process of
fixing this, plus a number of things raised by Sashiko[2][3].

Firstly, the miscellaneous patches:

 (1) Fix rxrpc_sendmsg so that it doesn't return an error if it queued the
     last packet of a call.  After that point, the error will be returned
     by recvmsg() and returned it twice in two different places may
     complicate userspace cleaning up its own structures.

 (2) Fix a UAF in afs_make_call() whereby it looks at the call after the
     first send (of the request) completes to see if it should make a
     second send (e.g. for FS.StoreData content) - but the call may have
     been freed if the first send wasn't marked MSG_MORE.

 (3) Fix afs_fs_fetch_data() to set call->async on calls marked as being
     asynchronous.

 (4) Fix error handling in rxrpc_send_data() for if ->secure_packet()
     returns an error.

 (5) Fix the update of call->pending in rxrpc_send_data() in paths when the
     call lock has been dropped.

 (6) Fix the generation of notifications from rxrpc after call completion.

 (7) Simplify afs_call refcounting to avoid trying to take refs when async
     call notifications come in, and worse trying to get rid of them again
     safely if the notifier work item is already queued.  This is not
     technically a bug fix, but the cleanup made patch 11 easier to handle.

 (8) Make afs_put_call() use an enum value to indicate when it happens
     rather than recording the function return address as the return
     address isn't sufficiently unique if functions get inlined or
     tail-called by the compiler.  This is not a bug fix, but it made it
     easier to debug the problem that patch 11 fixes.

 (9) Fix another UAF in afs_make_call() whereby the function tries to abort
     a call if the send fails, but the call may get torn down by async
     notification before we get there.

And then there are the patches to fix CHALLENGE packet overqueuing and
simplify RESPONSE packet generation by pre-creating the RxGK application
data up front and passing it in a user key (thereby allowing userspace to
partake).  This is split into five patches:

(10) Add a refcount to the user key payload.

(11) Make the AFS filesystem generate per-server appdata keys.

(12) Pass the appdata from AFS (or userspace) to rxrpc.

(13) Change over to using the appdata key to supply the appdata.

(14) Remove all the OOB stuff.

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

David Howells (14):
  rxrpc: Fix sendmsg to not return an error if last packet queued
  afs: Fix UAF when sending a message
  afs: Fix afs_fs_fetch_data() to set call->async
  rxrpc: Fix packet encryption error handling
  rxrpc: Fix update of call->tx_pending without holding lock
  rxrpc: Fix generation of notifications after call completion
  afs: Simplify call refcounting
  afs: Make afs_put_call() take trace argument
  afs: Fix UAF in afs_make_call()
  keys: Add refcounting to user-defined key type payload
  afs: Create a server appdata key
  rxrpc: Pass appdata key to rxrpc_call and thence to rxrpc_bundle
  rxrpc: Fix CHALLENGE packet overqueuing and simplify RESPONSE
    generation
  rxrpc: Remove OOB challenge/response code

 fs/afs/cm_security.c         | 311 +++++++++++++---------------
 fs/afs/cmservice.c           |  33 +--
 fs/afs/file.c                |  12 +-
 fs/afs/fs_operation.c        |   2 +-
 fs/afs/fs_probe.c            |   5 +
 fs/afs/fsclient.c            |   7 +-
 fs/afs/internal.h            |  63 +++---
 fs/afs/main.c                |   1 -
 fs/afs/rxrpc.c               | 137 +++++--------
 fs/afs/server.c              |   2 +-
 fs/afs/vl_probe.c            |   2 +-
 fs/afs/vlclient.c            |   8 +-
 include/keys/user-type.h     |   2 +
 include/net/af_rxrpc.h       |  21 +-
 include/trace/events/afs.h   |  46 +++--
 include/trace/events/rxrpc.h |   4 +-
 include/uapi/linux/rxrpc.h   |   6 +-
 net/dns_resolver/dns_key.c   |   1 +
 net/rxrpc/Makefile           |   1 -
 net/rxrpc/af_rxrpc.c         |  49 +----
 net/rxrpc/ar-internal.h      |  23 +--
 net/rxrpc/call_object.c      |   2 +
 net/rxrpc/call_state.c       |  57 +++++-
 net/rxrpc/conn_client.c      |   2 +
 net/rxrpc/conn_event.c       |  68 +-----
 net/rxrpc/key.c              |  37 ++++
 net/rxrpc/oob.c              | 387 -----------------------------------
 net/rxrpc/recvmsg.c          | 126 ++----------
 net/rxrpc/rxgk.c             | 128 +++---------
 net/rxrpc/rxkad.c            |  27 ---
 net/rxrpc/sendmsg.c          | 107 +++++++---
 net/rxrpc/server_key.c       |  40 ----
 security/keys/user_defined.c |  23 ++-
 33 files changed, 540 insertions(+), 1200 deletions(-)
 delete mode 100644 net/rxrpc/oob.c

