Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55928375F83
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773872429; cv=none; b=Gc83Mqaerc/Ey8y4HjcRQcu/WneOJzIok1n0J4Q1pxO9PF+EEA2sFwfdYQb0yG6IYXxe1XKRB0085hcaqfRMQbfTwNJfWNQPHrexSygHs+jIOZpd+vseEefYZ+7ngJm3IpNl2GS8vgsRBAC36QOzkV23qSt34L32+CWql+IYtIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773872429; c=relaxed/simple;
	bh=b1Rgor7zvm9/G3KBIKJYJdQLQhV2TkLSFa6fGTFlO2A=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=SBSy+VLVqu9Rki2erQ3Pbuin18I8epAuLbncVe1I0OnJp/oAuScHvXCAkuJELVa9I8ocQoweC+LxEI8N3U69cBTddr1otIRx+h8u4uwimeS3PkY02vuKmwBPiPsjycWpjqMUdnob5lvMOB7bLnW+4UnFuNUV52XLpWM/B+AriQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZkwyqWJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZkwyqWJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773872426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M+o8Q/Jj6lYoItKwu783Zkoj9hCpy6O9ilwkT2mHqYM=;
	b=iZkwyqWJ36XnceUhYGMVyIETA8je/DQ3Ad0/bq/MQhro2EqHPG97WNFBoFN9yvE0kUyL8b
	VCgJ+nBBww9w4G/pDIRgAT/nckqohtGMcfziDJ8H+/nH6EmzbeKoHG0tJi8++g3iop+QJx
	+cMRFODm5hSpeTBupv0JgDlENZduZs4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-n6POOmuvOIOIgDXfnWhl6A-1; Wed,
 18 Mar 2026 18:20:20 -0400
X-MC-Unique: n6POOmuvOIOIgDXfnWhl6A-1
X-Mimecast-MFC-AGG-ID: n6POOmuvOIOIgDXfnWhl6A_1773872419
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2849A1800371;
	Wed, 18 Mar 2026 22:20:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.45.224.65])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C0D4F30001A1;
	Wed, 18 Mar 2026 22:20:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260313132327.409785-3-anderson@allelesecurity.com>
References: <20260313132327.409785-3-anderson@allelesecurity.com> <20260313132327.409785-1-anderson@allelesecurity.com>
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
    edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
    horms@kernel.org, linux-afs@lists.infradead.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rxrpc: Fix key reference count leak in rxrpc_alloc_client_call()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3926713.1773872413.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Mar 2026 22:20:14 +0000
Message-ID: <3926716.1773872414@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Anderson,

I think the patch can be done better as the attached - and this takes care=
 of
another leak also.  Can you recheck your test?

Thanks,
David
---
commit 8e931ee13f267b814c0b668e9f52867b5239fed6
Author: Anderson Nascimento <anderson@allelesecurity.com>
Date:   Fri Mar 13 10:23:27 2026 -0300

    rxrpc: Fix key reference count leak from call->key
    =

    When creating a client call in rxrpc_alloc_client_call(), the code obt=
ains
    a reference to the key.  This is never cleaned up and gets leaked when=
 the
    call is destroyed.
    =

    Fix this by freeing call->key in rxrpc_destroy_call().
    =

    Before the patch, it shows the key reference counter elevated:
    =

    $ cat /proc/keys | grep afs@54321
    1bffe9cd I--Q--i 8053480 4169w 3b010000  1000  1000 rxrpc     afs@5432=
1: ka
    $
    =

    After the patch, the invalidated key is removed when the code exits:
    =

    $ cat /proc/keys | grep afs@54321
    $
    =

    Fixes: f3441d4125fc ("rxrpc: Copy client call parameters into rxrpc_ca=
ll earlier")
    Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
    Co-developed-by: David Howells <dhowells@redhat.com>
    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Marc Dionne <marc.dionne@auristor.com>
    cc: Eric Dumazet <edumazet@google.com>
    cc: "David S. Miller" <davem@davemloft.net>
    cc: Jakub Kicinski <kuba@kernel.org>
    cc: Paolo Abeni <pabeni@redhat.com>
    cc: Simon Horman <horms@kernel.org>
    cc: linux-afs@lists.infradead.org
    cc: netdev@vger.kernel.org
    cc: stable@kernel.org

diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 918f41d97a2f..8d874ea428ff 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -694,6 +694,7 @@ static void rxrpc_destroy_call(struct work_struct *wor=
k)
 	rxrpc_put_bundle(call->bundle, rxrpc_bundle_put_call);
 	rxrpc_put_peer(call->peer, rxrpc_peer_put_call);
 	rxrpc_put_local(call->local, rxrpc_local_put_call);
+	key_put(call->key);
 	call_rcu(&call->rcu, rxrpc_rcu_free_call);
 }
 =

