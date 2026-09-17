Received: from mail-oa2-f34.google.com (mail-oa2-f34.google.com [74.125.231.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06590248881
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789685149; cv=none; b=AngBAVY57XvAfyrkY2Kbp0NldklV7FUYQaL9JVQ14pWe98hnWhBeIp6rjE3LNxY9nAc30Rxoy+ujW2RfT4h5PdY9mxAAcpRAnO58vLJkxTsCe2GjS5RaACEHfx02VaRrGNgn3wJ3k9S9fiXHQFgf6J+eYzCtiKMrQd48p4xx0Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789685149; c=relaxed/simple;
	bh=B5DN+eGGTY8dL7H7lJNO1wrDusvbctciuRDTujptsWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZRD0JRJgDZc1TImfL5hJs+VijZmb0An/F9Lk5wdh6MUr5hQEE6z992PubQYpWyGWK4WMCO5GUl6euiV2ku/FzEhnQMS9nhme9PdZku6WGI0vMtc9tuuZEQEY9pfuljQXxaQyJj5ahbftTWzMS+VxAfUW4mPvtqkhWsUhlYU5m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Xj5iBGAM; arc=none smtp.client-ip=74.125.231.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Xj5iBGAM"
Received: by mail-oa2-f34.google.com with SMTP id 586e51a60fabf-466ccde2ad9so161631fac.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789685145; x=1790289945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=978dASIfIhQu1Ol7j5JKz97rGSQGc2WM2h0wAtRRXjw=;
        b=Xj5iBGAMCwYO7HiMDymna/ep+ylHqM304xaXuxMl1LISlKxuqO7fAXiQae0fQU7K4j
         ykxYRwN+o38MnoxZJKgcVzsKPCw4GLMOyoWdX02ftvMvEzlGyAozl22BdXLN8Y5LE3cR
         RHOe8acuF2CBP5jA2sVlBaPPDk3eQM9EUDf4GQ6gpuzjQSBbrcUe8ZAJyG/jc2WGg+20
         sE0OV6B6J8UrAuswe7wQDBEL+TEQYB07+/p5dLC+cacBSVdBWOsjWIgfEg9OEV+twyfI
         Fd71eY3X9zBUBetMNs65bCHlG7L++WudPYFcRlh4x0ijZ9LjzfJ1Exws+5mfTnM+e7oA
         h9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789685145; x=1790289945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=978dASIfIhQu1Ol7j5JKz97rGSQGc2WM2h0wAtRRXjw=;
        b=gaox+VsBI68B+uIROQVEAk1WMW/MrRglV2VdY2fGvACtre35VuQYLrHLSc7kKNXT83
         3XiCMbW7nZCB0UmM0RfSyUC+btqhuN33HRnQCnXqU9D1nH79v0irnGv19ZK0ZmNTNWfU
         Zllq9dsd4EV83VpP8hcReH0EcmINE9livGbkI9m0RigqEXviZ6fcAkjx2lHPlm94EeAp
         YDlKeY8KA+ZoeOVvQxy1JdzhESX+fgpZr2Z4rkrAFFkdvAV6GV/ZAqOTnH8iM/fQo/nK
         oNOVvkrFSeosbSQa/eGLhwO4qClpYrj1Y6JOusVFPoDsZx/15JEFMvbfaQoVnStVbEcs
         YECw==
X-Gm-Message-State: AFuF++nUzxI7I4lDRvVy0FSdoH30Ci4Izak4pedduOaHbaRhNcUbztd4
	6p/wAOPdEBDga1N/Ad30cKHIh4fQll/6B6G1XR2A8lD53KmMQlAVXQ7YnhHING7cC92jSkwZb7T
	oE16SBHXvzw5YcPUQjAgwIZkRHqc8LpF+UpNKB0fTnbV0YRlEI2/ME8jdMQll2GCmDEeELFV3bL
	ZIWF0nInMWwwmzZPI13Cwmv4wGCLs/6Xr81IS59adTMiV/tCs=
X-Gm-Gg: AYBFou1AJd8481YBLNDuLPH3PkpX7MqY5RdMpgpYClDYJgGdqamAZY9Uosk6IV/YcjB
	JY7fTbQtj1W94qaU0B7V3nA/8wqx0jbRMhA7NnmyaTFRcB3v4J2QG5TABi2AqdSgCvllYaF1WDT
	XZZu5kxW31A2+KXIUodZBmx3xlC5SBRreXHs8Cr/ldIANSEJPH5Dbvr4I+phopBDzoMlxh4wGGz
	tFdmVIWQ4qb2vGJnXSfYMxIgJzwP8iGoQ/NzlooF/HNrMyWD8V4NPk+AHHp7TYc/G6HHEh4x+hk
	3tDyoN3gS7cePXunhAEhzRw/Udj7BMYMwgqlM73voGLwceDxOZ+eVQThkEEIBE6bxqEae/q97qF
	Bc0MZzKqqKWLJtpBDY+dd4I9i6d1VEeTSdxA7Pfgtze6PkH7B6R2zVeasAEoSXaYi2Gn+Nnu6W2
	JGFwVL8OgYMI8J22KN+KHWCKnrTzMehhUoRTZy4Kk+SsQ4blWZGakowBkmcm3lD8O7PafO2T/xD
	iX/sJndPP+wyNpFE9OFsevwpK9y7FcCr4yiAxqVEPttU702xvaDkD3fQP5iVIYNuLGJYhmMN+72
	0zjzqWktgrlyM6U0FWPWVsDOI8cB+7L2vkPiqZgNmdn6WTXGzihgohGDbRUudQC0REf5zb0HMl5
	1DxsjRjfsZVR/D6CZfA==
X-Received: by 2002:a05:6870:3356:b0:485:d31b:775b with SMTP id 586e51a60fabf-486e6de49c8mr640294fac.25.1789685144324;
        Thu, 17 Sep 2026 15:45:44 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4870ac16ec0sm88605fac.5.2026.09.17.15.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:45:43 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	andrew.gospodarek@broadcom.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net-next v17 15/15] tls: document TLS 1.3 hardware offload rekey handling
Date: Thu, 17 Sep 2026 16:35:26 -0600
Message-ID: <20260917224355.2288021-16-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917224355.2288021-1-rjethwani@purestorage.com>
References: <20260917224355.2288021-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document TLS 1.3 support in the hardware offload path.

In Documentation/networking/tls-offload.rst, replace the stale note that
offload does not support TLS 1.3 with a description of the KeyUpdate
handling on both TX and RX, including how old-key records in flight are
bridged in software: each record is classified relative to the boundary at
which the NIC stopped using the old key, and partially transformed (mixed)
records are re-encrypted with the old key. In a mixed record the fragments
the NIC transformed but could not authenticate carry skb->decrypt_failed; a
non-mixed record with that flag was not transformed and is decrypted
directly.

In Documentation/networking/tls.rst, add the per-namespace rekey counters:
TlsCurrTxRekey/TlsCurrRxRekey for sessions currently in a deferred rekey,
TlsTxRekeyFallback/TlsRxRekeyFallback for rekeys that could not be
offloaded and fell back to software cryptography, and
TlsTxRekeyAborted/TlsRxRekeyAborted for deferred rekeys still pending when
the socket was destroyed.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 Documentation/networking/tls-offload.rst | 175 +++++++++++++++++++++--
 Documentation/networking/tls.rst         |  17 +++
 2 files changed, 183 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/tls-offload.rst b/Documentation/networking/tls-offload.rst
index e5802bcd4d22..cdf84f4b817a 100644
--- a/Documentation/networking/tls-offload.rst
+++ b/Documentation/networking/tls-offload.rst
@@ -99,9 +99,8 @@ at the end of kernel structures (see :c:member:`driver_state` members
 in ``include/net/tls.h``) to avoid additional allocations and pointer
 dereferences.
 
-When the offloaded connection is destroyed the core calls
-the :c:member:`tls_dev_del` callback so the driver can release per-direction
-state:
+The core calls the :c:member:`tls_dev_del` callback so the driver can release
+per-direction state:
 
 .. code-block:: c
 
@@ -109,7 +108,14 @@ state:
 			    struct tls_context *ctx,
 			    enum tls_offload_ctx_dir direction);
 
-``tls_dev_del`` is mandatory whenever ``tls_dev_add`` is provided.
+``tls_dev_del`` is called either when the offloaded connection is destroyed or,
+for a TLS 1.3 connection, when the old key is retired during a rekey (see the
+`Rekey`_ section). It operates on a single ``direction``, so the driver must
+release only the state for that direction and must not free state shared
+between directions or the socket as a whole. After a rekey ``tls_dev_del``,
+``tls_dev_add`` may be called again for the same socket and direction to
+install the new key. ``tls_dev_del`` is mandatory whenever ``tls_dev_add`` is
+provided.
 
 The third TLS device callback is :c:member:`tls_dev_resync`, called by the core
 to synchronize the TCP stream with the record boundaries:
@@ -205,7 +211,10 @@ Upon reception of a TLS offloaded packet, the driver sets
 the :c:member:`decrypted` mark in :c:type:`struct sk_buff <sk_buff>`
 corresponding to the segment. Networking stack makes sure decrypted
 and non-decrypted segments do not get coalesced (e.g. by GRO or socket layer)
-and takes care of partial decryption.
+and takes care of partial decryption. A segment the device processed but
+could not authenticate may instead carry the :c:member:`decrypt_failed`
+mark; see the `Error handling`_ section for what the mark implies about
+the payload.
 
 Resync handling
 ===============
@@ -404,8 +413,121 @@ records, then after 4 records, after 8, after 16... up until every
 Rekey
 =====
 
-Offload does not currently support TLS 1.3, therefore key rotation
-is not a concern for offloaded connections at this point.
+TLS 1.3 allows traffic keys to be updated mid-connection using the
+KeyUpdate message. Offloaded TLS 1.3 connections must therefore switch
+keys without tearing down the offload. The device cannot simply be given
+the new key because records encrypted (TX) or transformed (RX) with the
+old key may still be in flight. The stack retains the necessary old-key
+state and bridges the transition in software.
+
+TX
+--
+
+On TX, the new key is installed in a temporary software context, and
+sendmsg is routed through the software path. If no hardware-offloaded
+records remain unacknowledged, the switch completes inline during
+setsockopt. Otherwise the rekey is left pending and is completed later,
+on the sender's next ``sendmsg()`` after all old-key records have been
+ACKed (see `Completing a deferred rekey`_). Completion calls
+:c:func:`tls_dev_del` for the old key and reinstalls hardware offload
+with the new key at the current TCP write sequence. If reinstallation
+fails, the connection keeps encrypting in software with the new key; the
+next KeyUpdate re-arms the transition and retries the hardware
+installation.
+
+Unlike the software path, a ``TLS_TX`` setsockopt on an offloaded
+connection first flushes the open and partially sent hardware records to
+TCP before installing the new key. It therefore behaves like a blocking
+``send()`` of that record: it may wait for send buffer space (bounded by
+``SO_SNDTIMEO``), and on a non-blocking socket it fails with ``-EAGAIN``
+and must be retried once the socket is writable. The new key is not
+installed until the call succeeds; the connection keeps using the old key
+in the meantime.
+
+Completing a deferred rekey
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+A deferred rekey is completed by the sender, not by the ACK path. When
+the last old-key record is acknowledged the stack only marks the rekey
+as ready; the device is not touched. The switch itself,
+:c:func:`tls_dev_del` of the old key followed by :c:func:`tls_dev_add`
+of the new one, runs at the start of the next ``sendmsg()`` on the
+socket, and that ``sendmsg()`` is the first to be encrypted by hardware
+again. No other event completes it: ``splice_eof()``, write-space
+wakeups, retransmissions and pure ACKs all leave the connection on the
+software path.
+
+This is intentional. Completion has to flush the software context's
+open record to TCP and may sleep for send buffer space, which rules out
+the ACK and write-space paths. Beyond that, the stack only switches when
+it has new data to hand to the device: the software path is fully
+correct with the new key, so deferring the switch costs host CPU but
+nothing else, and it keeps the device from being programmed for a
+connection that may never send again.
+
+Two consequences follow. A connection that stops sending after a
+KeyUpdate stays in the deferred state until it is closed: it is
+encrypted in software with the new key, it is counted in
+``TlsCurrTxRekey``, and at close it is reported as
+``TlsTxRekeyAborted``. That counter therefore includes senders that
+simply had nothing more to send, not only sockets torn down
+mid-transition, and is not by itself an error indication. And the return
+to hardware is delayed by at least one ACK round trip after the last
+old-key record, plus however long the application waits before its next
+``sendmsg()``. A sender that wants the hardware path back promptly can
+issue a small ``sendmsg()`` once its old data has been acknowledged.
+
+Completion can fail transiently or permanently. If the software flush
+cannot get send buffer space (``-EAGAIN``, or a signal on a blocking
+socket) the rekey stays pending, the ``sendmsg()`` proceeds in software,
+and the next ``sendmsg()`` retries; the ``tls_device_complete_rekey_retry``
+tracepoint fires. A hard failure (:c:func:`tls_dev_add` rejected, or the
+netdev gone) is terminal for this KeyUpdate: the connection is pinned to
+software encryption with the new key, counted in ``TlsTxRekeyFallback``
+and moved from ``TlsCurrTxDevice`` to ``TlsCurrTxSw``; the
+``tls_device_complete_rekey_fail`` tracepoint fires. The next ``TLS_TX``
+setsockopt re-arms the transition and retries.
+
+The decision to defer is taken at the start of the ``TLS_TX``
+setsockopt, before the open hardware record is flushed to TCP. That
+flush may block for send buffer space, and old-key records acknowledged
+while it sleeps do not change the decision: the rekey is still deferred
+and completes on a following ``sendmsg()`` rather than inline. This is
+conservative, not a correctness issue. The boundary is fixed at the
+write sequence after the flush, so the acknowledgment of the flushed
+record itself arms completion; the cost is one more ACK round trip and
+one more ``sendmsg()``. Applications should not expect an inline switch
+whenever the socket has unacknowledged data at the time of the
+setsockopt.
+
+RX
+--
+
+On RX, the NIC may already have transformed in-flight records with the
+old key before the peer's KeyUpdate is parsed. When the KeyUpdate is
+decoded, the stack removes the old key from the NIC but retains the old
+AEAD, IV, and record sequence in the software offload context.
+
+Each record is classified by the TCP sequence of its first byte relative
+to the boundary at which the NIC stopped using the old key. Records
+starting after that boundary carry new-key wire encryption, so the old
+software AEAD state can be released. Records before the boundary that
+remain fully encrypted are passed to the software path. Records that
+were partially transformed by the NIC are re-encrypted with the old key
+to restore the new-key ciphertext, allowing the software AEAD to decrypt
+them with the new key.
+
+If old-key records are still queued, installation of the new key through
+:c:func:`tls_dev_add` is deferred until those records have been consumed;
+otherwise it occurs immediately. When the NIC cannot authenticate a record
+processed during the transition, the affected fragments are delivered with
+``skb->decrypt_failed`` set, following the contract described in the
+`Error handling`_ section. In a mixed record such a fragment was
+transformed (XORed) with the old key, and the re-encrypt path uses this to
+undo the transform on those fragments with the old key while leaving
+untouched fragments intact. A non-mixed record carrying
+``skb->decrypt_failed`` was not transformed; it is still wire ciphertext
+and is decrypted directly by the software AEAD under the new key.
 
 Error handling
 ==============
@@ -442,8 +564,43 @@ to the host's stack as it was on the wire (recovering original packet in the
 driver if device provides precise error is sufficient).
 
 The Linux networking stack does not provide a way of reporting per-packet
-decryption and authentication errors, packets with errors must simply not
-have the :c:member:`decrypted` mark set.
+decryption and authentication errors. A packet with errors must not have
+the :c:member:`decrypted` mark set. In addition, the driver may set the
+:c:member:`decrypt_failed` mark on a segment the device matched to an
+offloaded connection and processed but could not authenticate. The two
+marks are mutually exclusive.
+
+The stack interprets :c:member:`decrypt_failed` per record, relative to the
+:c:member:`decrypted` mark of the other segments making up the same record.
+Coalescing (GRO, socket layer) and record classification are keyed on
+:c:member:`decrypted` alone, so :c:member:`decrypt_failed` segments may be
+merged with unmarked ones. A driver setting the mark must therefore honour
+the following contract:
+
+ * In a record none of whose segments carry :c:member:`decrypted`, every
+   segment, including one with :c:member:`decrypt_failed` set, must hold
+   the payload exactly as it was on the wire. This is the general rule
+   above: if the device did not successfully decrypt any part of a record
+   it must hand the whole record over untouched. The stack passes such a
+   record to software decryption directly and does not consult
+   :c:member:`decrypt_failed`.
+
+ * In a record where some segments carry :c:member:`decrypted` (a mixed
+   record), a segment with :c:member:`decrypt_failed` set must hold payload
+   the device has already transformed (XORed with the cipher keystream) but
+   failed to authenticate, and a segment with neither mark must hold the
+   payload as it was on the wire. The stack re-encrypts the
+   :c:member:`decrypted` and :c:member:`decrypt_failed` segments to restore
+   the ciphertext, leaves the unmarked segments intact, and authenticates
+   the whole record in software.
+
+A transformed segment delivered without :c:member:`decrypt_failed`, or an
+untransformed segment of a mixed record delivered with it, is restored
+incorrectly and the record fails software authentication. A device which
+cannot tell the driver whether a failed segment was transformed must
+recover the original packet before handing it to the stack, as described
+above, and leave both marks clear. During a TLS 1.3 rekey the mark also
+tells the stack which key the device applied; see the `Rekey`_ section.
 
 A packet should also not be handled by the TLS offload if it contains
 incorrect checksums.
diff --git a/Documentation/networking/tls.rst b/Documentation/networking/tls.rst
index 980c442d7161..cf05543260d8 100644
--- a/Documentation/networking/tls.rst
+++ b/Documentation/networking/tls.rst
@@ -314,6 +314,11 @@ TLS implementation exposes the following per-namespace statistics
   number of TX and RX sessions currently installed where NIC handles
   cryptography
 
+- ``TlsCurrTxRekey``, ``TlsCurrRxRekey`` -
+  number of TX and RX sessions currently undergoing a deferred rekey,
+  i.e. a rekey which could not be applied immediately and is waiting for
+  in-flight records to drain before the new key is installed in hardware
+
 - ``TlsTxSw``, ``TlsRxSw`` -
   number of TX and RX sessions opened with host cryptography
 
@@ -344,3 +349,15 @@ TLS implementation exposes the following per-namespace statistics
 - ``TlsRxRekeyReceived`` -
   number of received KeyUpdate handshake messages, requiring userspace
   to provide a new RX key
+
+- ``TlsTxRekeyFallback``, ``TlsRxRekeyFallback`` -
+  number of rekeys on existing sessions for TX and RX which could not be
+  offloaded to the NIC and fell back to software cryptography
+
+- ``TlsTxRekeyAborted``, ``TlsRxRekeyAborted`` -
+  number of deferred rekeys for TX and RX which were still pending when
+  the socket was destroyed, and so never completed. For TX hardware
+  offload this includes senders that sent nothing further after the
+  KeyUpdate, since the switch back to hardware only happens on
+  ``sendmsg()`` (see the Rekey section of
+  Documentation/networking/tls-offload.rst)
-- 
2.50.1

