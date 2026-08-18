Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD52D97BA
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058250; cv=none; b=EG2fFP6kTbaBt6Nsts9qgrsU375dvf8fE9u2FDghoBxJtzWp8p8s1qC8HLEsHeyyjBv0TfLEkb555u7gQGXp+TELICGDKJytDQsJyb6sU0BN9Tj2B5p9NDSgrFH7YgAStIoMI8+l2zQw8JXBuGjGj4jtNzv1v8YveklDNT7r0oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058250; c=relaxed/simple;
	bh=K42okS3RtWkFnYNUUjlDpNHgGaUHBH2e0+LO8TRPGK4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=iHWtlK5PwRMpMWDfWx9Fnn9PxgOFuIB/vdJz8wYe1+pJORuJXFEoX7lkx8zOAmj2iwxZV4DwH64jI1eBvKVyU6DkCL0W++tfZeNPGhZ4et2N8gplc5O4wUwGa/b/xwce0pkuZaVAANHSWt23LXwd/IF//84nI3cJK38iimlYMZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eXwBZu1P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXwBZu1P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787058246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6bdFNBUxvpvyxut4BNaAI701FMdeJ5VUSTO8PBI5Ns=;
	b=eXwBZu1PUuJrdBFPmAKc4EIxi8JslGSj/l+1pjDYKjWXOkINIt2tERarSQlVXsciLVAPtf
	iPfMCAz/+99Dgqn3uz4b8CDCpp8unq1nOtNDGX8obq8AjNu1rZDLvvfmgz/N9DuS+Qm4Hv
	Tkw/YbAIdN9HuUpzSFvdgtLgTb5+4Cc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-cgvdKiPqNluIxCi9qshJQA-1; Tue,
 18 Aug 2026 09:04:05 -0400
X-MC-Unique: cgvdKiPqNluIxCi9qshJQA-1
X-Mimecast-MFC-AGG-ID: cgvdKiPqNluIxCi9qshJQA_1787058243
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DACB0180074B;
	Tue, 18 Aug 2026 13:03:58 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.6])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B9541800347;
	Tue, 18 Aug 2026 13:03:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260817185802.0aa4c9ee@kernel.org>
References: <20260817185802.0aa4c9ee@kernel.org> <20260812110129.979970-1-dhowells@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    "David S.
 Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v7 00/11] rxrpc: Fix CHALLENGE packet handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2038698.1787058233.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 14:03:53 +0100
Message-ID: <2038699.1787058233@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Jakub Kicinski <kuba@kernel.org> wrote:

> FWIW I had to kick off clashiko manually because sparse false-positives
> on one of the patches. It should finish in 30min or so. I'm signing off
> for the day, so please TAL if you can:
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260812110129.97997=
0-6-dhowells@redhat.com
> and let us know if we should ship v7 as is or you want to tweak..

Okay, there are only a couple of things that might merit producing a v8:

 (1) There's a missing key_put() in afs_open_socket()'s error path.

 (2) I should probably require READ permission on the key holding the appd=
ata
     provided by usespace through RXRPC_RESPONSE_APPDATA rather than SEARC=
H
     permission to prevent this being used to pull the data out of keys th=
at
     can't otherwise read directly with keyctl().

I can fix both of these with follow-up single line fix patches or (2) coul=
d
be fixed in place at the point of application:

--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -640,7 +640,7 @@ static int rxrpc_sendmsg_cmsg(struct msghdr *msg, stru=
ct rxrpc_send_params *p)
 			if (p->call.app_data)
 				return -EINVAL;
 			key_id =3D *(key_serial_t *)CMSG_DATA(cmsg);
-			key =3D lookup_user_key(key_id, 0, KEY_NEED_SEARCH);
+			key =3D lookup_user_key(key_id, 0, KEY_NEED_READ);
 			if (IS_ERR(key))
 				return PTR_ERR(key);
 			if (key_ref_to_ptr(key)->type !=3D &key_type_user &&

Everything else, I think, can be safely deferred.  I've discussed the poin=
ts
raised below.

David
---
=3D=3D=3D Patch 1

"This isn't a bug introduced by this patch, but should the kernel-doc for =
the
exported rxrpc_kernel_send_data() be updated in the same change?" - I can
address doc updates in an additonal patch.

"The two in-tree callers already disagree on how success is encoded:
fs/afs/rxrpc.c:afs_send_empty_reply() switches on "case 0:" while
afs_send_simple_reply() tests "n >=3D 0"." - That's probably worth fixing,=
 but
it'd be an AFS patch and isn't relevant to this patchset.

=3D=3D=3D Patch 2

"Is there a reachable case where len differs from
iov_iter_count(&msg->msg_iter) on entry to rxrpc_send_data()?" - This real=
ly
applies to all implementations of ->sendmsg(), not just rxrpc.  In theory,
maybe; but in practice I don't think so.  I did spend some time looking if=
 we
could eliminate the len argument entirely, but that doesn't need dealing w=
ith
here.  I've made the assumption that "len" controls how much we want to wr=
ite,
particularly for the purpose of marking the last packet, and if msg_iter i=
s
short, then we return a short send (if we've already filled a txbuf) or
-EFAULT (if we haven't) and don't mark last packet.  If there's more in
msg_iter, we just ignore the excess.

I can create an additional patch to fix the doc.

=3D=3D=3D Patch 3

"The changelog only describes rxrpc_send_data(), and doesn't mention this
fs/afs/rxrpc.c hunk at all." - That's not actually true; it even quotes th=
e
mention about converting to retry loops.

"Are the two lines immediately following now stale?" - True, but I can rem=
ove
the stale lines with a followup patch.

"Can -ENOMEM here leave a partially encrypted txbuf that is later encrypte=
d a
second time?" - The assumption is that if ENOMEM occurs, we haven't tried =
to
encrypt the buffer yet.  Even if a confounder has been inserted, that's no=
t a
problem as it's overwriting the specific bit of buffer reserved for it.  A=
 new
confounder can just be written over it.  skcipher shouldn't go down the sl=
ow
path as the buffer should be correctly aligned and encryption is done in
place.

"The second half of the concern is that the retry does not always re-copy =
the
plaintext." - This shouldn't matter.  If the packet is successfully encryp=
ted,
then txb/call->tx_pending should be cleared until we go back to the top of=
 the
loop and allocate a new txbuf.  As previously mentioned, the assumption is
that once we actually start encrypting, we should not fail with ENOMEM.

"Does this condition depend on an earlier patch in the series that isn't c=
c'd
to stable?" - An oversight, but I'm not sure it matters enough to respin.

=3D=3D=3D Patch 4

"Can this store ever move a non-NULL txb?" - Good point; txb must be NULL,
otherwise we wouldn't come down the wait_for_space branch.  But it doesn't
really need fixing; it just writes NULL twice to the same place under lock=
.

"The new out_nolock does "return copied ?: ret", so with copied > 0 the
negative value from the wait is discarded." - This change is correct.
Possibly it should have been mentioned in the changelog as a change of
behaviour.

"Also, the trace prints ret while the function returns "copied ?: ret"" - =
It
doesn't really matter, but I probably want to see the error that caused th=
e
return there.

=3D=3D=3D Patch 5

"This isn't a bug introduced by this patch, but since the code is being
relocated here it may be worth a look: should these nested sections use
spin_lock_irqsave()/spin_unlock_irqrestore() instead?" - No point as IRQs =
are
known to be enabled.

"I could not find an IRQ-context acquirer of either call->recvmsg_queue.lo=
ck
or rx->recvmsg_lock, so this looks like a fragility rather than a demonstr=
able
deadlock today." - The problem is that the app thread can otherwise hold u=
p
the I/O thread, particularly if realtime is involved.

"Further notifications are suppressed by putting recvmsg_link on a dummy
queue." - The comment needs updating, but that can be done with a follow-u=
p
patch.

"Should the prototype move too?" - Yeah.  A follow-up patch can do that.

=3D=3D=3D Patch 6

Nothing mentioned.

=3D=3D=3D Patch 7

"Should this patch carry a Fixes: tag?  It is cc'd to stable but does not =
name
the defect it fixes, nor the user-visible symptom in the AF_RXRPC challeng=
e
response path." - With regard to the keys patch, that's not technically a =
fix,
but a prerequisite.

"Does the comment block just above struct user_key_payload need updating?"=
 -
Yeah, but that can be a follow-up patch.

"Is the comment on put_user_key_payload() accurate?" - Ditto.

=3D=3D=3D Patch 8

"This isn't a bug introduced by this patch, but the new length calculation
here differs from the pre-existing one in afs_create_yfs_cm_token() in the
same file, which reads:" - Yeah, and also, as noted, the code is removed.

"Is anything reading server->yfs_rxgk_appdata as of this commit?" - See th=
e
next patch.

"Can a cached fileserver record end up being used for RxGK calls without e=
ver
getting appdata created?" - Yes, this can happen to probe calls for the
moment.  That can be fixed, but I think separately as it's purely work in
fs/afs/.

"and -ENOPKG is user-influenced, since rxrpc_preparse_xdr_yfs_rxgk() only
range-checks the token enctype rather than looking it up with
crypto_krb5_find_enctype()." - But it creates a callback key of the same t=
ype
as the key the user provides to make FS calls.  We don't get a CHALLENGE
packet until we have encrypted a DATA packet and sent it, in which case
-ENOPKG would have already happened.

If afs_create_token_key() fails, we can still do unencrypted Cache Manager
service comms, which is why I don't make it a fatal error.

"Does the address-update path silently swallow these new failures?" - Um,
that's really about talking to the VL server, not the FS server.  The VL
server doesn't involve interaction eith the CM service (that's just the
3rd-party change notification channel from the FS server).

Possibly there is a further bug here, but it's an AFS bug, not an AF_RXRPC
bug if so.

"Should this pick the same token that rxrpc will actually use for the
connection, rather than always the first one?" - This is actually a
pre-existing issue and needs more work.

=3D=3D=3D Patch 9

"Should Documentation/networking/rxrpc.rst be updated alongside this?" - T=
hat
actually needs a more comprehensive update and can be done separately.

"RXRPC_SUPPORTED_CMSG sees type 20 as available with nothing in the
documentation describing it, its key_serial_t payload, or the restriction =
to
key_type_user/key_type_logon keys." - Yeah.  I need to add that, but it ca=
n be
done in a follow-up patch.

"Should this case also validate p->command, or that the sendmsg() is going=
 to
create a new call?" - The parameter is just ignored if not creating a call=
.  I
suppose I could add a check that a call is being created - but that can be
done in a separate patch.

=3D=3D=3D Patch 10

"Can this path disclose the payload of a key the caller is not permitted t=
o
read?" - That's a good point and needs READ permission, not SEARCH permiss=
ion.
That can be followed up with a quick patch, I think, but might need the pa=
tch
respinning.

=3D=3D=3D Patch 11

"does afs_open_socket() leak the key created by afs_create_token_key()?" -
Yeah, that needs a fix.

"Should the rxrpc_abort_reason enum entry go too, in the same way as these=
?
EM(rxrpc_abort_response_sendmsg, "resp-sendmsg")" - That can be done in a
follow-up patch.

"With RXRPC_CHALLENGED gone from this enum, are the structs describing it
meant to stay in the same header?" - Those can be removed in a follow-up
patch.

"#define RXRPC_MANAGE_RESPONSE" - Ditto.

"setsockopt(SOL_RXRPC, RXRPC_MANAGE_RESPONSE)" - The stub handler for that=
 can
be removed in a follow up patch.

