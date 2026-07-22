Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F6D22B8DF
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756897; cv=none; b=ooYf+VpHyjyqkWRgWTb/InQy3ZquuXKvNoIGTECsqig72RtGud2Y9LkIuTVsd+/Nu4k+tQrQUslvx4Deo+Y+Vuk5VSbHA6lU8tlCq2nliyC3SwcDFWRRutexxe0lXQEawV/NEyYCxI4EMB0uRxWBiSRqNBOpUV0VYpeuWHwM/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756897; c=relaxed/simple;
	bh=jGzlniIlafj0UznBPX05BaKQdaQW3vSUwNApC7ryDwU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=eyLwpaxhlE02Gr5LDeaPMsAoVVH32j0zRQYD7BvbQJ/6fGR9Oy/P4PsgJ2chjj1fWzTJQHx7E/nMRNDuAUIfkcLxO3gnd6z9yNcWmZX2tTr63qPLXc8omSINdMSHqUySNdPmam9tsucBEBk4au5oZR1yjrLdrrmHsbLCkQIA9uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Siz1zDHQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Siz1zDHQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784756895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGzlniIlafj0UznBPX05BaKQdaQW3vSUwNApC7ryDwU=;
	b=Siz1zDHQIDAjaZC6OzLxj/d1WQK2buxX1oQY6fTlB9BkjLcOXIG4vMrg0IGO2AqAfTnFnP
	oh9QHpZwOazX9aQerAd5zj0hw5VkCXRhaUxIQ7J0jTnZ0QYwYb+gMQXyOLXicABeolFbG7
	st3o8tJum0/bhMduxyC17CYpnpZSh6Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-t0S9c4dvM32DUlMNRKfITg-1; Wed,
 22 Jul 2026 17:48:12 -0400
X-MC-Unique: t0S9c4dvM32DUlMNRKfITg-1
X-Mimecast-MFC-AGG-ID: t0S9c4dvM32DUlMNRKfITg_1784756890
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEDA1182E6A2;
	Wed, 22 Jul 2026 21:48:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4038C177;
	Wed, 22 Jul 2026 21:48:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260720145356.195862-1-horms@kernel.org>
References: <20260720145356.195862-1-horms@kernel.org> <20260713081022.2186481-12-dhowells@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    marc.dionne@auristor.com, kuba@kernel.org, davem@davemloft.net,
    edumazet@google.com, pabeni@redhat.com,
    linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
    stable@kernel.org
Subject: Re: [PATCH net v3 11/14] afs: Create a server appdata key
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <358857.1784756884.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 22:48:04 +0100
Message-ID: <358858.1784756884@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Simon Horman <horms@kernel.org> wrote:

> [Severity: High]
> Does this toksize calculation omit the 4 bytes required for the level fi=
eld? =

> =

> It looks like the sizes added up correspond to starttime (8), lifetime (=
4),
> bytelife (4), and expirationtime (8).
> =

> If the level field is omitted, toksize will be 4 bytes too small.

Yeah.

> Can this manual advance of the xdr pointer hide the token size mismatch?
>
> Because xdr is advanced based on the miscalculated encsize rather than t=
he
> actual number of fields written, it appears this will bypass the adatasi=
ze
> sanity check on the next line.

As it happens, the encryption padding hides the problem.

> When crypto_krb5_encrypt() executes, it seems it will only process the
> truncated toksize bytes of plaintext. This would leave the trailing 4 by=
tes
> of the serialized XDR unencrypted and overwritten by the appended Kerber=
os
> checksum. =


The buffer is sized and padded out by crypto_krb5_how_much_buffer() and
kzalloc() preclears it, so crypto_krb5_encrypt() happens to work correctly
most of the time as the data it encrypts is rounded out to a whole encrypt=
ion
blocks.

David

