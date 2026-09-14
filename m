Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FED41C2FB
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789427647; cv=none; b=eePKXRKymTH2i5fqYk2hDkJ9LLHim/hRNfF30BV4n8CckHLBZ2JWWJyZugWGF7mAivgKWTgu+D9P8YwFtsmguv64pjXSi2RF/ksn75RTlAWlO1quG6ianIlGGFA74VkdPTDjAls50BBsHJy93pYprmw2WI3ibVQj4f1Zd0n+i38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789427647; c=relaxed/simple;
	bh=IUYqUFTr8sxQiGE124PaJo3i+TtowJjWB7UWwA+bZYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYmkx9oxHkfDZcywWr3fJk1yauXna9nwwkqZFV/Es1Ael1Nk3rqtjOOX0LvVZ0v5bEq5TS2/siqYoZxAdivsxPI+BI8MtWELuDeU3IRPOgv89ojrrA3NTSSqY7D4rArIBEgPqLEzZgUZCKWqiG5D2qa0FFhFZO4xo1acEwj8OsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=mc/9kuNC; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="mc/9kuNC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WuY9sRpdwdmJT4FjtjhXZcS/K+Tuuf7t9g5t0UG5340=; t=1789427643; x=1790291643; 
	b=mc/9kuNCT8fb5QBWr4QQJr6xK3mR2IBE2fKRjzTHGqY81v6FvSuI8e3mArGaxNQY8dUH6tf0Vms
	+09/Q3kL/urxk3hO/I4i5ah61eHMruOs45ncm6etynodsl+859E3yXUEKIlY1E/RVSeny+71nSScB
	dyvEtu/Z6IO90oX6Lejg4dKeBfxZf7+sSEtmELAWNdvLPPnMe9ijO09SL5zKiLu599Bi/7HarC/+O
	0tF3Lba3dhFPrCG7xPmhDMU+f6a1BmqBRolK+7rHuHUzrbHf+e88WtCUUQAAx4pCqeHT8r8UHG9WQ
	aYJerMxc6OVly63k6ckzHtcURlnK+ZUjXCFw==;
Received: from ouster448.stanford.edu ([172.24.72.71]:60752 helo=cs.stanford.edu)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1x6Fjp-0007WN-6r; Mon, 14 Sep 2026 16:05:26 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	skhan@linuxfoundation.org,
	bagasdotme@gmail.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v11 01/15] net: homa: define user-visible API for Homa
Date: Mon, 14 Sep 2026 16:05:01 -0700
Message-ID: <20260914230517.1190-2-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260914230517.1190-1-ouster@cs.stanford.edu>
References: <20260914230517.1190-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: 05490b4d060761943944367086c22eb4

Note: for man pages, see the Homa Wiki at:
https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v20:
* Fix bug in ioctl number reservation in ioctl_number.rst (negative range).
* Ensure that homa_info has the same size on 32- and 64-bit machines.

Changes for v19:
* Change ioctl numbers to use numbers not currently in use.

Changes for v18:
* Fix types to conform to Linux standards (e.g. __u64 instead of size_t)

Changes for v16:
* Implement HOMAIOCINFO ioctl.

Changes for v14:
* Add "WITH Linux-syscall-note" SPDX license note

Changes for v11:
* Add explicit padding to struct homa_recvmsg_args to fix problems compiling
  on 32-bit machines.

Changes for v9:
* Eliminate use of _Static_assert
* Remove declarations related to now-defunct homa_api.c

Changes for v7:
* Add HOMA_SENDMSG_NONBLOCKING flag for sendmsg
* API changes for new mechanism for waiting for incoming messages
* Add setsockopt SO_HOMA_SERVER (enable incoming requests)
* Use u64 and __u64 properly
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   7 +
 include/uapi/linux/homa.h                     | 290 ++++++++++++++++++
 3 files changed, 298 insertions(+)
 create mode 100644 include/uapi/linux/homa.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 2fc53093752d..c6cb82ff627e 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -255,6 +255,7 @@ Code  Seq#    Include File                                             Comments
                                                                        <mailto:zapman@interlan.net>
 'h'   00-1F  linux/hpet.h                                              conflict!
 'h'   80-8F  fs/hfsplus/ioctl.c
+'h'   90-9F  uapi/linux/homa.h
 'i'   00-3F  linux/i2o-dev.h                                           conflict!
 'i'   0B-1F  linux/ipmi.h                                              conflict!
 'i'   80-8F  linux/i8k.h
diff --git a/MAINTAINERS b/MAINTAINERS
index 0e04d92d1b09..56e7651d0171 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11938,6 +11938,13 @@ F:	lib/test_hmm*
 F:	mm/hmm*
 F:	tools/testing/selftests/mm/*hmm*
 
+HOMA TRANSPORT PROTOCOL
+M:	John Ousterhout <ouster@cs.stanford.edu>
+S:	Maintained
+W:	https://homa-transport.atlassian.net/wiki/spaces/HOMA
+F:	include/uapi/linux/homa.h
+F:	net/homa/
+
 HONEYWELL ABP2030PA PRESSURE SENSOR SERIES IIO DRIVER
 M:	Petre Rodan <petre.rodan@subdimension.ro>
 L:	linux-iio@vger.kernel.org
diff --git a/include/uapi/linux/homa.h b/include/uapi/linux/homa.h
new file mode 100644
index 000000000000..deeca70f944a
--- /dev/null
+++ b/include/uapi/linux/homa.h
@@ -0,0 +1,290 @@
+/* SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0+ WITH Linux-syscall-note */
+
+/* This file defines the kernel call interface for the Homa
+ * transport protocol.
+ */
+
+#ifndef _UAPI_LINUX_HOMA_H
+#define _UAPI_LINUX_HOMA_H
+
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <linux/socket.h>
+#include <linux/types.h>
+
+/* IANA-assigned Internet Protocol number for Homa. */
+#define IPPROTO_HOMA 146
+
+/**
+ * define HOMA_MAX_MESSAGE_LENGTH - Maximum bytes of payload in a Homa
+ * request or response message.
+ */
+#define HOMA_MAX_MESSAGE_LENGTH 1000000
+
+/**
+ * define HOMA_BPAGE_SIZE - Number of bytes in pages used for receive
+ * buffers. Must be power of two.
+ */
+#define HOMA_BPAGE_SIZE (1 << HOMA_BPAGE_SHIFT)
+#define HOMA_BPAGE_SHIFT 16
+
+/**
+ * define HOMA_MAX_BPAGES - The largest number of bpages that will be required
+ * to store an incoming message.
+ */
+#define HOMA_MAX_BPAGES ((HOMA_MAX_MESSAGE_LENGTH + HOMA_BPAGE_SIZE - 1) >> \
+		HOMA_BPAGE_SHIFT)
+
+/**
+ * define HOMA_MIN_DEFAULT_PORT - The 16 bit port space is divided into
+ * two nonoverlapping regions. Ports 1-32767 are reserved exclusively
+ * for well-defined server ports. The remaining ports are used for client
+ * ports; these are allocated automatically by Homa. Port 0 is reserved.
+ */
+#define HOMA_MIN_DEFAULT_PORT 0x8000
+
+/**
+ * struct homa_sendmsg_args - Provides information needed by Homa's
+ * sendmsg; passed to sendmsg using the msg_control field.
+ */
+struct homa_sendmsg_args {
+	/**
+	 * @id: (in/out) An initial value of 0 means a new request is
+	 * being sent; nonzero means the message is a reply to the given
+	 * id. If the message is a request, then the value is modified to
+	 * hold the id of the new RPC.
+	 */
+	__u64 id;
+
+	/**
+	 * @completion_cookie: (in) Used only for request messages; will be
+	 * returned by recvmsg when the RPC completes. Typically used to
+	 * locate app-specific info about the RPC.
+	 */
+	__u64 completion_cookie;
+
+	/**
+	 * @flags: (in) OR-ed combination of bits that control the operation.
+	 * See below for values.
+	 */
+	__u32 flags;
+
+	/** @reserved: Not currently used, must be 0. */
+	__u32 reserved;
+};
+
+/* Flag bits for homa_sendmsg_args.flags (see man page for documentation):
+ */
+#define HOMA_SENDMSG_PRIVATE       0x01
+#define HOMA_SENDMSG_VALID_FLAGS   0x01
+
+/**
+ * struct homa_recvmsg_args - Provides information needed by Homa's
+ * recvmsg; passed to recvmsg using the msg_control field.
+ */
+struct homa_recvmsg_args {
+	/**
+	 * @id: (in/out) Initial value is 0 to wait for any shared RPC;
+	 * nonzero means wait for that specific (private) RPC. Returns
+	 * the id of the RPC received.
+	 */
+	__u64 id;
+
+	/**
+	 * @completion_cookie: (out) If the incoming message is a response,
+	 * this will return the completion cookie specified when the
+	 * request was sent. For requests this will always be zero.
+	 */
+	__u64 completion_cookie;
+
+	/**
+	 * @num_bpages: (in/out) Number of valid entries in @bpage_offsets.
+	 * Passes in bpages from previous messages that can now be
+	 * recycled; returns bpages from the new message.
+	 */
+	__u32 num_bpages;
+
+	/** @reserved: Not currently used, must be 0. */
+	__u32 reserved;
+
+	/**
+	 * @bpage_offsets: (in/out) Each entry is an offset into the buffer
+	 * region for the socket pool. When returned from recvmsg, the
+	 * offsets indicate where fragments of the new message are stored. All
+	 * entries but the last refer to full buffer pages (HOMA_BPAGE_SIZE
+	 * bytes) and are bpage-aligned. The last entry may refer to a bpage
+	 * fragment and is not necessarily aligned. The application now owns
+	 * these bpages and must eventually return them to Homa, using
+	 * bpage_offsets in a future recvmsg invocation.
+	 */
+	__u32 bpage_offsets[HOMA_MAX_BPAGES];
+};
+
+/** define SO_HOMA_RCVBUF: setsockopt option for specifying buffer region. */
+#define SO_HOMA_RCVBUF 10
+
+/**
+ * define SO_HOMA_SERVER: setsockopt option for specifying whether a
+ * socket will act as server.
+ */
+#define SO_HOMA_SERVER 11
+
+/** struct homa_rcvbuf_args - setsockopt argument for SO_HOMA_RCVBUF. */
+struct homa_rcvbuf_args {
+	/** @start: Address of first byte of buffer region in user space. */
+	__u64 start;
+
+	/** @length: Total number of bytes available at @start. */
+	__u64 length;
+};
+
+/**
+ * struct homa_rpc_info - Used by HOMAIOCINFO to return information about
+ * a specific RPC.
+ */
+struct homa_rpc_info {
+	/**
+	 * @id: Identifier for the RPC, unique among all RPCs sent by the
+	 * client node. If the low-order bit is 1, this node is the server
+	 * for the RPC; 0 means we are the client.
+	 */
+	__u64 id;
+
+	/** @peer: Address of the peer socket for this RPC. */
+	union {
+		struct __kernel_sockaddr_storage storage;
+		struct sockaddr_in in4;
+		struct sockaddr_in6 in6;
+	} peer;
+
+	/**
+	 * @completion_cookie: For client-side RPCs this gives the completion
+	 * cookie specified when the RPC was initiated. For server-side RPCs
+	 * this is zero.
+	 */
+	__u64 completion_cookie;
+
+	/**
+	 * @tx_length: Length of the outgoing message in bytes, or -1 if
+	 * the sendmsg hasn't yet been called.
+	 */
+	__s32 tx_length;
+
+	/**
+	 * @tx_sent: Number of bytes of the outgoing message that have been
+	 * transmitted at least once.
+	 */
+	__u32 tx_sent;
+
+	/**
+	 * @tx_granted: Number of bytes of the outgoing message that the
+	 * receiver has authorized us to transmit (includes unscheduled
+	 * bytes).
+	 */
+	__u32 tx_granted;
+
+	/** @reserved: Reserved for future use. */
+	__u32 reserved;
+
+	/**
+	 * @rx_length: Length of the incoming message, in bytes. -1 means
+	 * the length is not yet known (this is a client-side RPC and
+	 * no packets have been received).
+	 */
+	__s32 rx_length;
+
+	/**
+	 * @rx_remaining: Number of bytes in the incoming message that have
+	 * not yet been received.
+	 */
+	__u32 rx_remaining;
+
+	/**
+	 * @rx_gaps: The number of gaps in the incoming message. A gap is
+	 * a range of bytes that have not been received yet, but bytes after
+	 * the gap have been received.
+	 */
+	__u32 rx_gaps;
+
+	/**
+	 * @rx_gap_bytes: The total number of bytes in gaps in the incoming
+	 * message.
+	 */
+	__u32 rx_gap_bytes;
+
+	/**
+	 * @rx_granted: The number of bytes in the message that the sender
+	 * is authorized to transmit (includes unscheduled bytes).
+	 */
+	__u32 rx_granted;
+
+	/**
+	 * @flags: Various single-bit values associated with the RPC:
+	 * HOMA_RPC_BUF_STALL:  The incoming message is currently stalled
+	 *                      because there is insufficient receiver buffer
+	 *                      space.
+	 * HOMA_RPC_PRIVATE:    The RPC has been created as "private"; set
+	 *                      only on the client side.
+	 * HOMA_RPC_RX_READY:   The incoming message is complete and has
+	 *                      been queued waiting for a thread to call
+	 *                      recvmsg.
+	 * HOMA_RPC_RX_COPY:    There are packets that have been received,
+	 *                      whose data has not yet been copied from
+	 *                      packet buffers to user space.
+	 */
+	__u16 flags;
+#define HOMA_RPC_BUF_STALL    1
+#define HOMA_RPC_PRIVATE      2
+#define HOMA_RPC_RX_READY     4
+#define HOMA_RPC_RX_COPY      8
+};
+
+/**
+ * struct homa_info - In/out argument passed to HOMAIOCINFO. Fields labeled
+ * as "in" must be set by the application; other fields are returned to the
+ * application from the kernel.
+ */
+struct homa_info {
+	/**
+	 * @rpc_info: (in) Address of memory region in which to store
+	 * information about individual RPCs. Actual type is
+	 * "struct homa_rpc_info *".
+	 */
+	__u64 rpc_info;
+
+	/**
+	 * @rpc_info_length: (in) Number of bytes of storage available at
+	 * rpc_info.
+	 */
+	__u64 rpc_info_length;
+
+	/**
+	 * @bpool_avail_bytes: Number of bytes in the buffer pool for incoming
+	 * messages that is currently available for new messages.
+	 */
+	__u64 bpool_avail_bytes;
+
+	/** @port: Port number handled by this socket. */
+	__u32 port;
+
+	/**
+	 * @num_rpcs: Total number of active RPCs (both server and client) for
+	 * this socket. The number stored at @rpc_info will be less than this
+	 * if @rpc_info_length is too small.
+	 */
+	__u32 num_rpcs;
+
+	/**
+	 * @error_msg: Provides additional information about the last error
+	 * returned by a Homa-related kernel call such as sendmsg, recvmsg,
+	 * or ioctl. Not updated for some obvious return values such as EINTR
+	 * or EWOULDBLOCK.
+	 */
+#define HOMA_ERROR_MSG_SIZE 104
+	char error_msg[HOMA_ERROR_MSG_SIZE];
+};
+
+/* I/O control calls on Homa sockets.*/
+#define HOMAIOCINFO  _IOWR('h', 0x90, struct homa_info)
+
+#endif /* _UAPI_LINUX_HOMA_H */
-- 
2.43.0

