Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D729E463B62
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293432; cv=none; b=n08C8LsxhmZ/yajqpcdYDmx3RKK1qJ9fLNBUOkxS/ze/TRI6sJYRtAAxPEH1f/Ha8G4yQUucH+Y8LBiIQ3jmcazkWoEg3nUFkr6NWXbTAMUt1Ub1IIH5lHOeEAhXSK/edweNweqNWW+E2aUWbPCXBXbYmq9LaitO+zQ/zuDYwKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293432; c=relaxed/simple;
	bh=rSUUquvoB43XPJaRYDwS4RFetKYJwQLKq4ZB1pePqIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKGgl4ZXi/MOvOTAyBswoIxnjxqgwPxj7h9uGm/P1TPHpfCyRi9akIbiEpaQA/dFX/trwR0OphYSP+sKyQEGRA/O2t/iLTxy2wCNJHld/KGXmDFz17Mi9pYFnDmfPjAeV/bzKHaQUp6XVyQs1BYjk6OPBylmPXJPWZIWvNgEQZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AWNfdqqW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWNfdqqW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791293428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ww10vZ6IdFChzXansyOJfHvpT6AYdcsw6NmPOVe5Q2E=;
	b=AWNfdqqWfCaFxNXYuihowq8tQaDh6bd43/3dwj8RM0Hy0f0BF03nJW7DjMq+AsDugwSEOl
	cQTtQ7W2/m2nIjQHi2LF/DEe5P0a58iUPs6Sw3U4RcUq+iTW5ZKxTz6+1wqijj7hb242nD
	Z2Xcoe5TXPyLsnQySARpGY9YfeyXQR0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-zbwkIRrqOOCLczrq_m5bEQ-1; Tue,
 06 Oct 2026 09:30:22 -0400
X-MC-Unique: zbwkIRrqOOCLczrq_m5bEQ-1
X-Mimecast-MFC-AGG-ID: zbwkIRrqOOCLczrq_m5bEQ_1791293420
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4147018512F0;
	Tue,  6 Oct 2026 13:30:20 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.90])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1EA0A418;
	Tue,  6 Oct 2026 13:30:16 +0000 (UTC)
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
Subject: [PATCH net v12 00/15] rxrpc: Miscellaneous fixes
Date: Tue,  6 Oct 2026 14:29:52 +0100
Message-ID: <20261006133011.531806-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

(This has been split from "rxrpc: Fix CHALLENGE packet handling")

Here's a set of  miscellaneous patches, mostly found by sashiko.  Note that
a number of the patches have been reworked and reordered after the last
sashiko round[10].

 (1) Revert patch to rxperf to expect the magic cookie at the end of the
     request.

 (2) Fix the kvno on rxperf's test rxgk keys to be 0 to match other
     implementations.

 (3) Fix the update of call->tx_pending in rxrpc_send_data() in paths when
     the call lock has been dropped.

 (4) Fix rxrpc_kernel_send_data() to loop around on a short send.

 (5) In AFS, fix various callers of rxrpc_kernel_send_data() to abort the
     call on send error.

 (6) As (2) but for the rxperf test server.

 (7) Fix the use of len vs msg->msg_iter.count in rxrpc_send_data().

 (8) Fix double IRQ enablement in __rxrpc_notify_socket() when called
     indirectly from rxrpc_end_rx_phase().

 (9) Fix error handling in rxrpc_kernel_recv_data() to distinguish between
     end-of-request from end-of-call.  Upstream a return of 1 is used for
     both, but we mustn't shut down an incoming service call at the end of
     request as there's still the processing and reply transmission to
     come.

(10) Fix the cleanup of in-progress service calls when a socket is shut
     down by a kernel app, notifying the app about each call as it is
     aborted.

(11) Fix the way rxrpc_send_data() and thus rxrpc_sendmsg() handles a
     variety of error conditions:

     - If it queued the last packet, then no error is returned, only how
       much data is returned.

     - Otherwise, if one of a number of errors occur that mean that going
       on with a call is futile, just return that error.  If the call was
       terminated, -ESHUTDOWN is returned, no matter the reason, and
       recvmsg() will fetch the reason.

     - Otherwise, if some bytes were copied in, return that.

     - Otherwise, return an error.

(12) Fix error handling in rxrpc_send_data() for if ->secure_packet()
     returns an error.

(13) Fix the generation of notifications from rxrpc after call completion.

(14) Fix the rxrpc key parser to check that the enctype is supported in an
     RxGK key.

(15) Fix rxrpc_poke_conn() to only queue the conn if the refcount hasn't
     yet hit 0.

David

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=rxrpc-fixes

Changes
=======
ver #12)
- Rebased on latest net/main.
- Removed cleanup for old, no longer used call accept queue.
- Fixed more Sashiko-reported bugs[12]:
  - Fixed afs to change the call state to "complete" after local abort due
    to send error on a service call.
  - Fixed the wait functions used by rxrpc_send_data() to return -ESHUTDOWN
    if a call gets to the "complete" state for consistency with
    rxrpc_send_data().
  - In rxrpc_send_data(), remove the now superfluous TX_NO_MORE check from
    the "maybe_error:" section.
  - Move the patch that alters the return of rxrpc_recvmsg_data() to
    earlier than the patch that alters rxrpc_send_data()'s return.
  - Added a patch to make sure that kernel socket service calls get
    completion notifications when those calls are aborted because their
    socket is being released.
  - Updated def of rxrpc_notify_end_tx_t in docs.
- Dropped three of the afs patches for the moment as the sashiko comments
  on those need more consideration.
- Moved the recvmsg patch and irq patch before the senddata patch.

ver #11)
- Rebased on latest net/main.
- added a patch to revert patch to rxperf to expect the magic cookie at the
  end of the request.
- Added a patch to fix rxperf rxgk key kvno.
- Fixed more Sashiko-reported bugs[11]:
  - Moved the patch to fix unlocked update of call->tx_pending to the
    front.
  - Made the RXRPC_CALL_TX_NO_MORE check unlock before returning in the
    tx_pending patch.
  - Switch 'ssize_t/int n' to 'int ret' for handling the return value from
    rxrpc_kernel_send_data().
  - Made rxperf also abort if the main reply data loop send fails.
  - Fixed rxrpc_kernel_recv_data() to differentiate in its return between
    received-everything and call-complete for service calls (Rx then Tx) as
    this is substantially different from client calls (Tx then Rx).
  - Removed checks for -EINPROGRESS from rxrpc_kernel_recv_data() as it
    doesn't return that.
  - Fixed rxrpc_send_data() to go to out_unlock: not out: on error.
  - Ordered the rxrpc_send_data() return chart comment a bit better.
  - Fix the rxrpc key parsing code to only account used tokens to the
    key quota.

ver #10)
- Rebased on latest net/main.
- Implemented David Laight's suggestion to loop around inside
  rxrpc_kernel_send_data() rather than in its callers.
- Changed rxrpc_kernel_send_data() to return 0 on success, not the amount
  buffered.
- Fixes rxperf to not double-abort on ENOMEM.
- Fixed more Sashiko-reported bugs[10]:
  - Removed extra blank line.
  - Fixed potential infinite loop in rxperf.
  - Rearranged the patches to deal with the sendmsg len vs msg_iov.count
    potential discrepency first and then deal with the missing locking
    around ->tx_pending - and then other rxrpc_send_data() changes.
  - Changed rxrpc_send_data() to move the txb variable into the main loop
    and otherwise always leave the current txbuf attached to
    call->tx_pending.
  - Described the return value from rxrpc_send_data() in various situations
    in a comment and adjust the code to match, in particular:
    - Always using -ESHUTDOWN to indicate that the call has been completed
      already and that recvmsg() needs to be used to find the reason.
    - Better handling of a sendmsg/sendmsg race where one side fills up the
      buffer whilst the other side is waiting.
  - Fixed afs and rxperf to check for -ESHUTDOWN and then receive the error
    value.
  - Fixed rxrpc_send_data() to rewind by the last amount copied rather than
    trying to calculate this in case we waited and another thread copied
    some data in.
  - Added comment on why rxrpc_requeue_call() doesn't check RXRPC_CLOSE
    (rxrpc_recvmsg() doesn't check it either).
  - Fixed the RxGK key parsing stuff to be conditional on CONFIG_RXGK=y so
    that checking the key type doesn't fail to compile.
  - Added a key length check when parsing an RxGK key since the enctype
    check makes the enctype description available.
  - Added a patch to fix afs_wait_for_operation() to clear op->call before
    rotation can happen.
  - Drop the patch to fix a data race for the moment whilst I consider if
    the barriering points brought up by sashiko affect it.

ver #9)
- Rebased on latest net/main.
- Fixed more Sashiko-reported bugs[9]:
  - Changed Fixes line for "rxrpc: Fix sendmsg to not return an error if
    last packet queued".
  - Split the change to call rxrpc_kernel_send_data() in a loop in afs into
    its own patch and put that first.
  - In AFS, always abort a call if rxrpc_kernel_send_data() gives an error.
  - Added a patch to make the rxperf server loop around when sending the
    magic cookie.
  - Fix rxrpc_send_data() to only return -EPROTO or -EIO only in the case
    that no data was copied if TX_NO_MORE or TX_ERROR are set.
  - Fix commit message to say call->user_mutex, not call->lock.
  - Removed comment on rxrpc_notify_socket() about putting recvmsg_link on
    a dummy queue.
  - Added a patch to check that the RxGK enctype is supported in an rxrpc
    key.
  - Move the check for net->fs_cm_token_key being valid from
    afs_create_yfs_rxgk_cm_appdata() to its caller and just return okay if
    it is NULL (it should've been created during module load).
  - Added a patch to fix the calculation of the RxGK CM token in AFS, even
    though the code is then deleted by a later patch.
  - Made rxrpc_kernel_query_key() pick the first token with a supported
    security index, rather than just picking the first token.
  - Fix the docs for RXRPC_RESPONSE_APPDATA.
  - Split the setting of call->server in afs_make_op_call() out into its
    own patch as a separate fix.
- Split the OOB-Challenge fixes out for the moment.
- Imported a patch to fix rxrpc_poke_con() to avoid queuing a dead conn.
- Imported a patch to fix a data race when initialising an RxGK conn.

ver #8)
- Rebased on latest net/main.
- Fixed more Sashiko-reported bugs[8]:
  - Fixed the kerneldoc on rxrpc_kernel_send_data() as this returns the
    number of bytes buffered on success.
  - Fixed rxrpc_send_data() to break out of the loop if either len or
    msg_iter's count becomes 0 and to limit the amount per copy to the
    msg_iter count also.
  - Fixed the docs for rxrpc_kernel_send_data()'s return value.
  - In afs_make_call(), remove duplicate error check and make sure the
    afs_sent_data tracepoint gets called on the error path.
  - In rxrpc_send_data() remove setting of the already-NULL txb and
    tx_pending to NULL.
  - Added a patch to fix __rxrpc_notify_socket() to save the old IRQ state
    when disabling it as the call chain may have it disabled.
  - Removed comment on __rxrpc_notify_socket() about putting recvmsg_link
    on a dummy queue.
  - Moved rxrpc_notify_socket()'s declaration to the right file section in
    ar-internal.h.
  - Updated the comment on the user_key_payload struct.
  - Updated the comment on put_user_key_payload().
  - In afs_open_socket(), fixed a missing ref cleanup on error.
  - Updated the docs for rxrpc_kernel_begin_call().
  - Added docs for RXRPC_RESPONSE_APPDATA cmsg.
  - Fixed rxrpc_sendmsg_cmsg() to require that the appdata key have its
    description prefixed by "rxrpc-appdata:" to prevent the reading out of
    arbitrary keys through a fake filemanager.
  - Dropped the use of logon keys for appdata.
  - Removed rxrpc_abort_response_sendmsg.
  - Removed struct rxrpc_challenge and struct rxgk_challenge.
  - Removed the RXRPC_MANAGE_RESPONSE constant and its rxrpc_setsockopt()
    stub.

ver #7)
- Rebased on latest net/main.
- Added a patch to change rxrpc_send_data() to use len rather than msg_iter
  count to be consistent about the amount to send so as to do the LAST flag
  determination correctly.
- Fixed more Sashiko-reported bugs[7]:
  - Made the loops in afs_make_call() that call rxrpc_kernel_send_data()
    pass the amount left in the iterator rather than an unreducing size.
  - Made the second loop in afs_make_call() check to see if
    rxrpc_kernel_send_data() returned an error.
  - Removed yet more OOB references, two in linux/af_rxrpc.h and one in
    rxrpc.rst.

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
[7] https://sashiko.dev/#/patchset/20260804172639.2844491-1-dhowells%40redhat.com
[8] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260812110129.979970-6-dhowells@redhat.com
[9] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com
[10] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com
[11] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914151340.3227501-1-dhowells%40redhat.com
[12] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923133706.1496540-1-dhowells%40redhat.com

David Howells (14):
  rxrpc: Revert "rxrpc: rxperf: Fix missing decoding of terminal magic
    cookie"
  rxrpc: Fix rxperf test rxgk key kvno to be 0
  rxrpc: Fix update of call->tx_pending without holding lock
  rxrpc: Fix lack of short-send handling in rxrpc_kernel_send_data()
  afs: Fix afs to abort the rxrpc call on send error
  rxrpc: Fix aborting in rxperf test server
  rxrpc: Fix sendmsg length
  rxrpc: Fix double IRQ enablement
  rxrpc: Fix return in rxrpc_recvmsg_data() for service calls
  rxrpc: Fix the cleanup of service calls when socket shut down
  rxrpc: Fix error handling in rxrpc_send_data()
  rxrpc: Fix packet encryption error handling
  rxrpc: Fix generation of notifications after call completion
  rxrpc: Fix RxGK key parser to check enctype is supported

Seungwon Bae (1):
  rxrpc: fix use-after-free in rxrpc_poke_conn()

 Documentation/networking/rxrpc.rst |  38 +++--
 fs/afs/rxrpc.c                     |  68 +++-----
 include/net/af_rxrpc.h             |   5 +-
 include/trace/events/rxrpc.h       |   6 +-
 net/rxrpc/ar-internal.h            |   3 +-
 net/rxrpc/call_object.c            |   1 +
 net/rxrpc/call_state.c             |  57 ++++++-
 net/rxrpc/conn_object.c            |   5 +-
 net/rxrpc/key.c                    |  41 +++--
 net/rxrpc/recvmsg.c                |  57 +++----
 net/rxrpc/rxperf.c                 |  73 ++++-----
 net/rxrpc/sendmsg.c                | 253 +++++++++++++++++++----------
 12 files changed, 384 insertions(+), 223 deletions(-)

