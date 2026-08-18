Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1A4344036
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064563; cv=none; b=sWEktLn1LRHw+NwLAOlzzHFjXOwQ6w8nx9uPfoFzep6wZOf+r8H3gH6o0EjHo+4eq2dJGTSsMFRym6HkRilhdVDsBugG8pVNPBHEwiUtH+Bx6mNauB8obWk9tjE2yjmnyXiXb8t40ln2Vk5kbEYzrsH8XYwhx8LeZjHSHkMRMqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064563; c=relaxed/simple;
	bh=ssPhy2viDC861/AVe2aA6O1WH6mBI9LlnCXVpUufQ1g=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=SJBFrqlpk6pAM0oxXKFp15ReKOJDq2B3/fVYWmnNUqKkaj5p8GPwISRIu/vhBkOViTp6wLduM719lAi+W3U+sAqy6K657lze+ynMnYnU4e4v9wDcj6SLfRuwDES/lE2duSMQKl3mn18dUYQe5JpbPbhwffKDxm3wmOfoTbVmN0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnwZ2DJK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnwZ2DJK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787064558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dlgnweTvn/E9Fu3uLw0PrOhY0MHYkOKCVxiRxtOm5ag=;
	b=JnwZ2DJKFWZ26E8hy75qyZaNFwHjNY0+o6Gw54sT++q+BdjlLI+Iu7FcGW1aYNrWhlB67g
	ToAmYTAJVqptprUabswnyEoDWeXM7G6/kVXGEJU1FSsL3HoMJqFvLSpXrOPFqqUpB17aqq
	m8WETFX10iR0M/+RvBCwGBleP/G4olQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-jA-x4H4EOLK5gWo9txFucQ-1; Tue,
 18 Aug 2026 10:49:15 -0400
X-MC-Unique: jA-x4H4EOLK5gWo9txFucQ-1
X-Mimecast-MFC-AGG-ID: jA-x4H4EOLK5gWo9txFucQ_1787064553
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1643F18001D7;
	Tue, 18 Aug 2026 14:49:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.6])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 19C10180034F;
	Tue, 18 Aug 2026 14:49:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2038699.1787058233@warthog.procyon.org.uk>
References: <2038699.1787058233@warthog.procyon.org.uk> <20260817185802.0aa4c9ee@kernel.org> <20260812110129.979970-1-dhowells@redhat.com>
Cc: dhowells@redhat.com, Jakub Kicinski <kuba@kernel.org>,
    netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
    "David S. Miller" <davem@davemloft.net>,
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
Content-ID: <2088509.1787064548.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:49:08 +0100
Message-ID: <2088510.1787064548@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

David Howells <dhowells@redhat.com> wrote:

> =

>  (2) I should probably require READ permission on the key holding the ap=
pdata
>      provided by usespace through RXRPC_RESPONSE_APPDATA rather than SEA=
RCH
>      permission to prevent this being used to pull the data out of keys =
that
>      can't otherwise read directly with keyctl().
> =

> I can fix both of these with follow-up single line fix patches or (2) co=
uld
> be fixed in place at the point of application:
> =

> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c
> @@ -640,7 +640,7 @@ static int rxrpc_sendmsg_cmsg(struct msghdr *msg, st=
ruct rxrpc_send_params *p)
>  			if (p->call.app_data)
>  				return -EINVAL;
>  			key_id =3D *(key_serial_t *)CMSG_DATA(cmsg);
> -			key =3D lookup_user_key(key_id, 0, KEY_NEED_SEARCH);
> +			key =3D lookup_user_key(key_id, 0, KEY_NEED_READ);
>  			if (IS_ERR(key))
>  				return PTR_ERR(key);
>  			if (key_ref_to_ptr(key)->type !=3D &key_type_user &&

Actually, there's a better way to do this, and that's to check the prefix =
on
the key description.  See attached patch.

David
---
commit 6d456b373d5c7cf2c1c9f5ead0e563c75e739442
Author: David Howells <dhowells@redhat.com>
Date:   Tue Aug 18 14:30:37 2026 +0100

    rxrpc: Fix user appdata key check
    =

    The check made by rxrpc_sendmsg_cmsg() for RXRPC_RESPONSE_APPDATA on t=
he
    key it retrieves allows keys to be accessed by generating
    CHALLENGE/RESPONSE exchange.  Currently, any user or logon key can be
    accessed in this manner.  Fix this by restricting the patch descriptio=
n to
    require a prefix of "rxrpc-appdata:".
    =

    Fixes: xxxxxxxxxxxx ("rxrpc: Fix CHALLENGE packet overqueuing and simp=
lify RESPONSE generation")
    Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/202608121101=
29.979970-6-dhowells@redhat.com
    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Marc Dionne <marc.dionne@auristor.com>
    cc: Jeffrey Altman <jaltman@auristor.com>
    cc: Eric Dumazet <edumazet@google.com>
    cc: "David S. Miller" <davem@davemloft.net>
    cc: Jakub Kicinski <kuba@kernel.org>
    cc: Paolo Abeni <pabeni@redhat.com>
    cc: Simon Horman <horms@kernel.org>
    cc: Jarkko Sakkinen <jarkko@kernel.org>
    cc: linux-afs@lists.infradead.org
    cc: keyrings@vger.kernel.org
    cc: stable@kernel.org

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 4755fc76d8f3..eb3dc352684e 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -648,6 +648,13 @@ static int rxrpc_sendmsg_cmsg(struct msghdr *msg, str=
uct rxrpc_send_params *p)
 				key_ref_put(key);
 				return -EINVAL;
 			}
+			if (!key_ref_to_ptr(key)->description ||
+			    strncmp(key_ref_to_ptr(key)->description,
+				    "rxrpc-appdata:", 14) !=3D 0) {
+				key_ref_put(key);
+				return -EINVAL;
+			}
+				=

 			p->call.app_data =3D key_ref_to_ptr(key);
 			break;
 =

