Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2579A317144
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 05:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791178586; cv=pass; b=DkfQpeFJlQxZKD73DmMDbjd1vdWsxHaJCBMum7VdTWtAJ9mPzQXdMO39bARaZJZV29LdVfAt/C+eUuU817/co2VkHfd+sMnmlKmTClLZDpgeuaW+LyhBZKJ7YUTSI7udjHNUkoOwFcs12k6Gulf1cJliE9ajYDJv2SbW9mqMfVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791178586; c=relaxed/simple;
	bh=3bVd4/6TRuhZlFLsNTUd/ze81RF7sNEE2/3G7QyK20k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HbCouNyYiGu79326zF8ksIcCMrR6tmN8v1JnbVtd6h8bsjndrMX+60HKjsx2ALVT4QM8gSZhcM6ELVT6b9fFyR9b3xs4RjyAyiR9KJT1keGhTFh6vWaTeDhCb9Eg7umZcne/3mm0MFnHOOepb3FtHH/F5LHYUEWwCwbb+mpKyyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sy0koghN; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy0koghN"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c25085f2422so19894566b.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 22:36:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791178583; cv=none;
        d=google.com; s=arc-20260327;
        b=M38CTiFCToLGHA3IZUqvZPBmOf4XDpMA2s5Fhnus3Qo4mZE99YrcZyTbiAUuFF1UBf
         4hohAwUVfC1htcuZV37kx6HPJAfykYiJCzrPowjugdS0uyqG1HXN/u1HU5SSgKm4eokq
         zJBfCETQo2A4mOs+KcnxtA/i9WkwE7XP/zK1ZqcG38uIJ+Nf3dLLKTR0oxm5BLHVoF6h
         QhkbZQSPDq/it8QJZiY+KUI8A8fAUz8gZrb8qAgM0lWHz5W0DkQ5RrJj8MOR5Iae3Ryj
         tCNDv3KmNabMgDKu3Zac3V8JyIxduIBZGdTgXH+0DS5yIDjv0u+imhjWkqtoxW3QTlMY
         w9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3bVd4/6TRuhZlFLsNTUd/ze81RF7sNEE2/3G7QyK20k=;
        fh=dfVhUmM6J97K2mJ+zv1zhxeKO4uUjsuJuWY9Sngrn4U=;
        b=MrcSJcACOe5RWHAfwqND/x31yT2dbmfVmF6yKxhhFyRObEgtlIUXUK+YZWE034cYKj
         XWiEkTLJ33kx0Ml3MOEOeVKOHIP0F13CUCe96l5lQWsgV+UsDxKgVb5HUgZEq8YytWaJ
         vYqzrI6Q9BwwaYsGmpU23ncFC9ZFPcVYSrqYWt3vxcfWLscZoGgpVc44pLCdjbViNinU
         /vXVxa0u35jJz+SYUdhcKOIvegAKNPNuf8Hp+KUq7jfAfAgFf5mKmcJnpP83SegNmjA/
         6p7mg5Pg7SI/YIGip1xmmvjFh24U0nAc0M4aJedkdmec8T+MLDAbYdPlVn+rzRT0Z5JX
         svTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791178583; x=1791783383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3bVd4/6TRuhZlFLsNTUd/ze81RF7sNEE2/3G7QyK20k=;
        b=Sy0koghN9HrqAdBi0waqOhWkjHJaM7e2TwA+032M+AXUB43q/37pA06hC4BpZshCgq
         TikkJYWDi6dxkfl+VguwZPtYVT6E3rj9bS3ZdXaSgu7tyPZfB6rCIpX3Z+dHQ3WyNmlc
         +bwYZFrkVHC8cwYBNnQIeCM12xqDeNMhl+VHUkZsH8RJxmf1noLCO6g5nSvtvoKHYOIK
         94wqkKjM8q0wsrCsQszssSGavnHXdqxwejQnamwQ2ZGL9CBVzvb+bsRZPvSvSMDcaw1T
         qNJmg0/fEg/5a/Y1pCjhzczdwi8LpVZEt8xvJCx6bmfGRs63Ka78vmIedC4EcO3KXqr1
         MMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791178583; x=1791783383;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3bVd4/6TRuhZlFLsNTUd/ze81RF7sNEE2/3G7QyK20k=;
        b=sTlVkDIHox91lJiEtHykVz+h1gYrAQx4VEPMglKccypzhuPMA1HMFWQWn/hbU91oqo
         jd/ujkHQv9G7RC9934ykR5p2neg2v7VrlQ9+mZvhQPcW+dLNOiBiJnS4WUYKO5uAwxR7
         cJs/B0fJKwG7iB4HUOWVNUJgGG8OG5Fn8T/6Qv/PGjBQ1+pDnDuqZWBeJ5qAmMh7Xc6d
         vttdtdISn8AAkFaI8N/+r5AdB5zinM25PYr6NxrIcDzlZ9Wvq9xUHJjqF1rCRw3/aGQM
         r9ZqjNlqgbL/Eg1uBsORR0yf/twG+r6YhQFhm3hUsrDjZKeqPfjFWi0LkukPfZKIw3+G
         mA4w==
X-Forwarded-Encrypted: i=1; AKwUvBzXrirW3VczXGyae8wXUQgj5etrytPmY4M+idEZ1LnbpQIRyeynDQtIbchSP6yqZ0lmqSZqO/E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUD84N1zC6kBnU7Uu45D2oZJiTz1NboCt3DCGNA5YQ4a+nENUA
	YhNk6Sy64x2XUBBm0xXh7/+PbV0oKJXw65YeSITPznzD3ZKxPqPvN49kafbPSyO1nTl8QW8xc1T
	+AdXRR1kAXAKl/iBASCwCHfZI+MJSnQY=
X-Gm-Gg: AYBFou0AebWWRBCv7kSESDG+islhuX2A6TSMVWTEEgSiz6Vmofhbua9F/Nq/VljgxiZ
	nWyMjiKj1G1pM8YZ8VvJ6W/u7m+lZ7cMSReHTnMcWYBPzr9I1hY8V0jcUP/QWAgFPOrdKU1b557
	gERMjhhqNdnMv6QQ38AjBYLh75XvZPB5+8fjE9hDHiyMFP4JLrcWEldB3XbV8bze38sI4JUpFpp
	tPyBaq1fNvmxii3hCa2qJQRyUOcf0+7wsOmynxusqSM1hyWMdvWjPH/PQDKGIVbtFAMaaxIY/9B
	wL2jw3h0I1gz23T2ZDm/7IZHDquMUP3uRRKUucqarGQokNh0DcAKx8GK7OUlMC9+6fjQu/54YBn
	eW2tOMLRvynM=
X-Received: by 2002:a05:6402:50d2:b0:6aa:91c2:63b0 with SMTP id
 4fb4d7f45d1cf-6af9e2e7068mr8641383a12.2.1791178583097; Sun, 04 Oct 2026
 22:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927180806.1315902-1-nicoyip.dev@gmail.com>
 <20261001182924.3928331-1-nicoyip.dev@gmail.com> <20261001182924.3928331-2-nicoyip.dev@gmail.com>
 <DU4P189MB375033B6F5978460BB988D89C6962@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <DU4P189MB375033B6F5978460BB988D89C6962@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 5 Oct 2026 13:36:11 +0800
X-Gm-Features: AclHuK8fAsMrI3qzzV8uWswviu1Yxpd03vOYqXZXhNud5CFUwzH2-M436KXUFEc
Message-ID: <CAAo+4rXFxvqNvo8BOsX5gDScidFfk-aq1oZeakXw=_Ufk-41Pw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tipc: unlink publications without a node lookup
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 12:08=E2=80=AFPM Tung Quang Nguyen
<tung.quang.nguyen@est.tech> wrote:
>
> >Subject: [PATCH net v2 1/2] tipc: unlink publications without a node loo=
kup
> >
> >The two remote-publication removal paths remove a publication from the
> >name table and call tipc_node_unsubscribe() before scheduling it for fre=
eing.
> >
> >tipc_node_unsubscribe() looks up the publishing node by address and retu=
rns
> >without unlinking when the node has already disappeared from the hash. T=
he
> >publication is then freed while its binding_node remains linked, so a la=
ter
> >publication-list traversal can access freed memory.
> >
> >Both paths already run under nametbl_lock. Unlink binding_node directly
> >under that lock instead of performing another node lookup. For a valid r=
emote
> >publication, binding_node is either on the node publication list or is i=
nitialized
> >as an empty list when subscription failed. Remove the now-unused helper =
and
> >address arguments.
> >
>
> This does not fix the root cause of this issue: Not holding proper lock i=
n tipc_node_write_unlock().
> I will post fix for this issue. Thanks for your report.

Thanks for your help on it.

Best regards,
Chengfeng
