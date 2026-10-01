Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8A34A4828
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841484; cv=none; b=uivrizcFgG88I5ey5pguaGqMHpoHnOZcy5U9xxXLbOKbxucEAOun10jw15KzPu6XKcfPOoI/E0PNeopUnhOip9+gCg9Aqhg3X2nOrb/8kG9iHXf9CYnW0q0jsl+25m+S3Tst4w45Ac/dkpUs14PMOvK+DrGN5+wcd92T21XHVvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841484; c=relaxed/simple;
	bh=ov1UsvgqnGP99ZlV0po8t6D8z04tML2PYCHslCttodI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOZ4VOGIHKI5YEXpUmq6BEjSZpBIy7Bf3ZvKDRTuUDU50kDOqKXhZy3n+zyQWDG8sinP8jjMU0siIIyOOK+Ge7qlQOdBYXCaop1LD6gCS4IhXPSj0i4FIkWnqez4srnJrQtHufP/gx9Ms5uvLZEgNAjZWmNHOJ6bZ0UUC4iJftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=G/CZsVU5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m+cBUrjW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="G/CZsVU5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m+cBUrjW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 024A71D00113;
	Thu,  1 Oct 2026 03:58:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 01 Oct 2026 03:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790841480; x=
	1790927880; bh=PY/o21IhUS0fzBW3cqrn1HrNwN+W+8gbpBSP5c9/yQo=; b=G
	/CZsVU5RM0DbDfIoaFwIANE8ZaYf1HEQ3yyBQwbJdtzOA34VSAC3ZBtO7mqaHrw/
	ScsXa1rwyouzSVW8Y+O8abPEMMhx9vPuVxYQ1gsA+YLxotkqejWT7V8ePbQfDX3Q
	7bJNON8k93d+HGrP3zevfcipjOOyhIsVcaLcHxIFCniNIQhadba5t51/TxGnQ1tv
	Jj6/XMZaDUxvH1M6LOORAQZK7EBSblCLV2+7o4LWB+TC5SbbP1evxXhTCuIIPuVU
	9NEbFbEZeNnH7G6KZ2gNy30CEsu9ZaUeg1utgk5D7p1FWPlpDpBrT0oD57HrZW8k
	u40WSPRjtD+aW2eIevg+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790841480; x=1790927880; bh=P
	Y/o21IhUS0fzBW3cqrn1HrNwN+W+8gbpBSP5c9/yQo=; b=m+cBUrjWKbzeJjWQy
	Zh/fVNFYYeXKPOEJZ8PHzrKt6U/YZ56Ml12y04QMt0VkU7tkNFBkW8I3CBfPr4a+
	KV4qmDQOyxkYXpHZ6uLTtnW1OAlQYdwJhAYxWfKz163iM2hbxsDKEKODiPa1xBkM
	Kbdl/8ORF680y06XByRYv6QjlibBzDaaY77Ah/U6RRK9HFd8r77yNmHyynRCayzI
	sQLlB7D5uNis9b/Lh0e2hWeJWYD3JNBa4zaLwD+a5OyhyIPUTtqWFh3q0xhAFs7b
	5on19EFNYCa9uyIqgX/ECts80I+6OlzzPXYYMVji1Lq29LPqejIhR8gz7Atb9SJs
	ppn5g==
X-ME-Sender: <xms:iBK-auFh0f-yCgiOI4m57QsY_n0v0PgpIwZ3Ct11Nh_myJ5hElsGew>
    <xme:iBK-alVyFjwp8qD-fa0RyomeMe-Z8hHpJ8-vVFhMAypLCy3P_QTEGDWnAJdHPgj7y
    vyOGwE5DfesOCRfLyXe5UyZoRUqPuIuOGJBo6htwNVqQe_Sgmx4wcbh>
X-ME-Received: <xmr:iBK-alwC7BCdEfg5KeBX_tMEI7uNkPydSHcVjmTR3pQOq-9qIvbCDB112lXI>
X-ME-Proxy-Cause: dmFkZTGA/oXDmtyuaJ03IsPgZQeRlS3NjW8epWdBScf6nCzEY2mbZqv2ZjIMukknW64/dT
    FVbgtfCcUrd6FlB44rQNfqzZkAsTz7yM3qSnJC/AUotm4uvUQ5XW2kB7VTtplnbv33IcmR
    APrgFEPxWNMh10FVKM1e6PDSL9lbq+OjRG1DDUNesQtUT/97G01G2rU89A0Q3kdHPmsMSw
    nynIoH82FSZGrBTKeUfmB/EJwQJTeMwFHp9SZ4eqVLsfXi3RmJ6XzKv6CJlLw4J7oG67wg
    M2wJeJDkfuRrjRnge4oQb1QoCApu/aR8nuPvmIJgmL+CGh5S+yHnxGR3jFPn1UupRCZLhe
    AwN/39Tc/uU8JXKwbWN/DWw1t1YMn6UoYVxpz/G1bVgEuh+DMlvahI+Lf2uMtGvdGMD9ct
    zbZcYE0fmonrhk4wluZNgIZeBtjK/UqZz5YrEOq7FYg53LsW10piTAdwCb/gOaZrygCha/
    l+hRbXySQ1PZcWKfhSP/uwMYqvx/iLwVZZQ2lu8ai9Q0BClQZLUlUreYU2UASYYHVpDCmP
    zNiiyodBVzrOWZcXg9bee2g4WrwU9O/cL7nFeIByhlPFG4AFfXK/SoCB5y9j2YV4mDCx3Y
    iOk/vpiKIrelu2C49icR9Tv1wPDVFsHx9f/yAWIZtbj+Wd4Ck7R5mv4Dlfug
X-ME-Proxy: <xmx:iBK-ajPyRVvKyIQVwnCrbDndo4OD0husP6dyBhA9EMueF8SOc_F0DQ>
    <xmx:iBK-am5vLB8wg1zCIjSNH9sSUe99OpqIKbfPnvwO5rJg6CvgnFMWOw>
    <xmx:iBK-akMxCO365gH6iJ0874im_U7cpEWTRmTu9xIu9i67A34DyqupRg>
    <xmx:iBK-akneF6hTtnBLg4XTJx3-gf6uUgwg80rPRBbSWQD2x9kXBY3zgg>
    <xmx:iBK-apf0yREQBb1sLCZYw3qb3sEVdTEou2UCrt1pEvrGpim4x2ruLHhJ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 03:58:00 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 5/5] docs: networking: strparser: remove general mode
Date: Thu,  1 Oct 2026 09:57:29 +0200
Message-ID: <0a31a783d4c9c38594da338c49bf085fe6336c92.1790702233.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790702233.git.sd@queasysnail.net>
References: <cover.1790702233.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the general mode of strp has been removed from the code,
update the documentation.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 Documentation/networking/strparser.rst | 120 ++++++++-----------------
 1 file changed, 36 insertions(+), 84 deletions(-)

diff --git a/Documentation/networking/strparser.rst b/Documentation/networking/strparser.rst
index 372106b61e65..9a21bbe93691 100644
--- a/Documentation/networking/strparser.rst
+++ b/Documentation/networking/strparser.rst
@@ -8,32 +8,24 @@ Introduction
 ============
 
 The stream parser (strparser) is a utility that parses messages of an
-application layer protocol running over a data stream. The stream
+application layer protocol running over a TCP connection. The stream
 parser works in conjunction with an upper layer in the kernel to provide
 kernel support for application layer messages. For instance, Kernel
 Connection Multiplexor (KCM) uses the Stream Parser to parse messages
 using a BPF program.
 
-The strparser works in one of two modes: receive callback or general
-mode.
-
-In receive callback mode, the strparser is called from the data_ready
-callback of a TCP socket. Messages are parsed and delivered as they are
-received on the socket.
-
-In general mode, a sequence of skbs are fed to strparser from an
-outside source. Message are parsed and delivered as the sequence is
-processed. This modes allows strparser to be applied to arbitrary
-streams of data.
+The strparser is called from the data_ready callback of a TCP
+socket. Messages are parsed and delivered as they are received on the
+socket.
 
 Interface
 =========
 
 The API includes a context structure, a set of callbacks, utility
-functions, and a data_ready function for receive callback mode. The
-callbacks include a parse_msg function that is called to perform
-parsing (e.g.  BPF parsing in case of KCM), and a rcv_msg function
-that is called when a full message has been completed.
+functions, and a data_ready function. The callbacks include a
+parse_msg function that is called to perform parsing (e.g. BPF parsing
+in case of KCM), and a rcv_msg function that is called when a full
+message has been completed.
 
 Functions
 =========
@@ -45,9 +37,8 @@ Functions
 
      Called to initialize a stream parser. strp is a struct of type
      strparser that is allocated by the upper layer. sk is the TCP
-     socket associated with the stream parser for use with receive
-     callback mode; in general mode this is set to NULL. Callbacks
-     are called by the stream parser (the callbacks are listed below).
+     socket associated with the stream parser. Callbacks are called by
+     the stream parser (the callbacks are listed below).
 
      ::
 
@@ -79,18 +70,6 @@ Functions
      parser instance. This must be called after the stream processor
      has been stopped.
 
-     ::
-
-	int strp_process(struct strparser *strp, struct sk_buff *orig_skb,
-			 unsigned int orig_offset, size_t orig_len,
-			 size_t max_msg_size, long timeo)
-
-    strp_process is called in general mode for a stream parser to
-    parse an sk_buff. The number of bytes processed or a negative
-    error number is returned. Note that strp_process does not
-    consume the sk_buff. max_msg_size is maximum size the stream
-    parser will parse. timeo is timeout for completing a message.
-
     ::
 
 	void strp_data_ready(struct strparser *strp);
@@ -112,16 +91,15 @@ Functions
 Callbacks
 =========
 
-There are seven callbacks:
+There are four callbacks:
 
     ::
 
 	int (*parse_msg)(struct strparser *strp, struct sk_buff *skb);
 
-    parse_msg is called to determine the length of the next message
-    in the stream. The upper layer must implement this function. It
-    should parse the sk_buff as containing the headers for the
-    next application layer message in the stream.
+    parse_msg is called to determine the length of the next message in
+    the stream. It should parse the sk_buff as containing the headers
+    for the next application layer message in the stream.
 
     The strparser metadata in the input skb can be accessed with
     strp_msg(skb). Only the offset field is relevant in parse_msg and
@@ -141,30 +119,13 @@ There are seven callbacks:
     =========    ===========================================================
 
     In the case that an error is returned (return value is less than
-    zero) and the parser is in receive callback mode, then it will set
-    the error on TCP socket and wake it up. If parse_msg returned
-    -ESTRPIPE and the stream parser had previously read some bytes for
-    the current message, then the error set on the attached socket is
-    ENODATA since the stream is unrecoverable in that case.
-
-    ::
-
-	void (*lock)(struct strparser *strp)
-
-    The lock callback is called to lock the strp structure when
-    the strparser is performing an asynchronous operation (such as
-    processing a timeout). In receive callback mode the default
-    function is to lock_sock for the associated socket. In general
-    mode the callback must be set appropriately.
+    zero), it will set the error on TCP socket and wake it up. If
+    parse_msg returned -ESTRPIPE and the stream parser had previously
+    read some bytes for the current message, then the error set on the
+    attached socket is ENODATA since the stream is unrecoverable in
+    that case.
 
-    ::
-
-	void (*unlock)(struct strparser *strp)
-
-    The unlock callback is called to release the lock obtained
-    by the lock callback. In receive callback mode the default
-    function is release_sock for the associated socket. In general
-    mode the callback must be set appropriately.
+    This callback must be set.
 
     ::
 
@@ -173,8 +134,7 @@ There are seven callbacks:
     rcv_msg is called when a full message has been received and
     is queued. The callee must consume the sk_buff; it can
     call strp_pause to prevent any further messages from being
-    received in rcv_msg (see strp_pause above). This callback
-    must be set.
+    received in rcv_msg (see strp_pause above).
 
     The strparser metadata in the input skb can be accessed with
     strp_msg(skb). This struct contains two fields: offset and full_len.
@@ -182,6 +142,8 @@ There are seven callbacks:
     the length of the message. skb->len - offset may be greater than
     full_len since strparser does not trim the skb.
 
+    This callback must be set.
+
     ::
 
 	int (*read_sock)(struct strparser *strp, read_descriptor_t *desc,
@@ -189,25 +151,20 @@ There are seven callbacks:
 
     The read_sock callback is used by strparser instead of
     sock->ops->read_sock, if provided.
+
+    This callback is optional.
+
     ::
 
 	int (*read_sock_done)(struct strparser *strp, int err);
 
      read_sock_done is called when the stream parser is done reading
-     the TCP socket in receive callback mode. The stream parser may
-     read multiple messages in a loop and this function allows cleanup
-     to occur when exiting the loop. If the callback is not set (NULL
-     in strp_init) a default function is used.
-
-     ::
+     the TCP socket. The stream parser may read multiple messages in a
+     loop and this function allows cleanup to occur when exiting the
+     loop. If the callback is not set (NULL in strp_init) a default
+     function is used.
 
-	void (*abort_parser)(struct strparser *strp, int err);
-
-     This function is called when stream parser encounters an error
-     in parsing. The default function stops the stream parser and
-     sets the error in the socket if the parser is in receive callback
-     mode. The default function can be changed by setting the callback
-     to non-NULL in strp_init.
+    This callback is optional.
 
 Statistics
 ==========
@@ -224,23 +181,18 @@ Message assembly limits
 The stream parser provide mechanisms to limit the resources consumed by
 message assembly.
 
-A timer is set when assembly starts for a new message. In receive
-callback mode the message timeout is taken from rcvtime for the
-associated TCP socket. In general mode, the timeout is passed as an
-argument in strp_process. If the timer fires before assembly completes
-the stream parser is aborted and the ETIMEDOUT error is set on the TCP
-socket if in receive callback mode.
+A timer is set when assembly starts for a new message. The message
+timeout is taken from rcvtime for the associated TCP socket. If the
+timer fires before assembly completes the stream parser is aborted and
+the ETIMEDOUT error is set on the TCP socket.
 
-In receive callback mode, message length is limited to the receive
+Message length is limited to the receive
 buffer size of the associated TCP socket. If the length returned by
 parse_msg is greater than the socket buffer size then the stream parser
 is aborted with EMSGSIZE error set on the TCP socket. Note that this
 makes the maximum size of receive skbuffs for a socket with a stream
 parser to be 2*sk_rcvbuf of the TCP socket.
 
-In general mode the message length limit is passed in as an argument
-to strp_process.
-
 Author
 ======
 
-- 
2.55.0

