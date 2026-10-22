Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792667202;
	b=RinyjOWYVtISad7G+tI/Aa+fOq+/19ZoJAGV5BVbfwtx1zKlv1dYJd6pklLN1DqFI54u
	 fIMIVuJVk9yK76qSuVZAfpJBqloyT3JpwBXxFzMC9XdhUNHRcU/QiqrkALYRqMx0yl7dd
	 F5F5aDGaWpEi8cXSI7BWLqupBZSxx7VSjFspfE3v7OiuHB9kmYPH9fv1K9dn53VDMj+a1
	 N7An4yFmO7i/swypZz8V5U6P+GC9Y9Meta5DCWrle9wg6gTHGYsDSiD9nhtrsjCKnrAR2
	 okhIXC56jZwdcE7B6gr+8txLYshCv04/pqpIIt9Q7zxfv6Qb2Jq6aANE5r8X/fgbIhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667202;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=xyOyJxMQ69YYHJQNozgzVZmUmKFP/XM6lCT0sjk2uzw=;
	b=PErJSaCcVCPo4hCEObbJhTO8a1i3qmieP1U56eBRP3chs2KC6bngdDOAcsCkGzPGhcsf
	 cc4FQqtZ073yBN+FsurdPx6FE9CLIfxBrHadkAa2uMK5a+d3kMNYs+Fpagsgoa+y4t2Ii
	 Ict9kxnCdXf67CNyaxbVmwdJkp0XjWLSMUavE3wCfL8o1BAtAItTZ6VSdjBNYfU+3fkUz
	 VnJGDvtDZPpn8v3aRCqVYmJLvTn3xPMXgt63jBXHON+3V6hWigPCe6PcIWy0geub5NFkT
	 NhAj+WDqjhdQ73ick5UJWn209cfWwB3mlPPI1DCVjiST0zqVhkhx1caDtzuLin0vq+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnqAu3al;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A258606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnqAu3al
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C8B1F000C6
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 11:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792667201;
	bh=xyOyJxMQ69YYHJQNozgzVZmUmKFP/XM6lCT0sjk2uzw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VnqAu3aluJYl12qKjic1cjl1jt89jwBWTfhlSawM2+IPoJfacvQMpyIZO+Bhs+CMc
	 GVIHtl1YSL5Kx3NR52HcmRnE0S6P/RKCs5WPY4Ci64/Y1KWXp/RTHnSzKsb9LFj6nD
	 iCYDTNWoxNEgO26kW8+VBLS0iSg1mqddtVi9U5qEEa5RvHfP/rSUuGGHhERNFuiL/C
	 n31gL3bdznG/658InT5Gjj6Xe7HNUPt7hwe35blGMnTHAP/AsgaNAND5giMR8GPpMZ
	 mqljMN//KfF0d52wHN5jWikzW1hrcD2RApO5y/nLarCNdyIKkL1/4TbrYH1qdP1Gwe
	 oXGLw03C7ulQQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-48e9476e26aso702103fac.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 04:06:41 -0700 (PDT)
X-Gm-Message-State: AFq9FYLaLJ1tK2BjdWjNPN36Koy+PqpUJPWJjZXQtzrfQ18n7Yla84Mf
	FZCnRtCjX/Uiui4yfUIoeDfdQl7ajXhbKl2+4ghDDzkXuKCdh3a4qNnHoGky4X+DwOXaqulfiFR
	GSnjlNL5wicHMznxpNfVoKI/PkhLEs1A=
X-Received: by 2002:a05:6870:ac1e:b0:47d:4141:6248 with SMTP id
 586e51a60fabf-4a7dc2823a9mr3325025fac.30.1792667201216; Thu, 22 Oct 2026
 04:06:41 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022104217.1852191-1-pointerliu@126.com>
In-Reply-To: <20261022104217.1852191-1-pointerliu@126.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 13:06:29 +0200
X-Gmail-Original-Message-ID: <CAL4WiiqsmV8yKzU_HnE5tFXHqf8rMabGP9_-4B6gAdGZwhzjOQ@mail.gmail.com>
X-Gm-Features: AclHuK8s4n2wbqM2GmJ_qfaTtbQ4-ruc6q-HN6ENlhgolb_xi9FSnmK-OYjbiqE
Message-ID: <CAL4WiiqsmV8yKzU_HnE5tFXHqf8rMabGP9_-4B6gAdGZwhzjOQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: skbuff: propagate shared-frag marker in skb_zerocopy()
To: Zizhen Liu <pointerliu@126.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 22 oct. 2026 =C3=A0 12:43, Zizhen Liu <pointerliu@126.com> a =C3=A9=
crit :
>
> skb_zerocopy() moves frag descriptors from @from into @to and takes a
> reference on each frag, but it does not copy skb_shinfo(from)->flags into
> skb_shinfo(to)->flags.  A destination skb holding the same page-cache
> backed frags as the source therefore reports skb_has_shared_frag() as
> false.
>
> That breaks the invariant relied on by later in-place writers.  ESP input
> checks skb_has_shared_frag() before deciding whether an uncloned
> nonlinear skb can skip skb_cow_data(); with the marker lost, an skb that
> skb_zerocopy() built for nfnetlink_queue or for an openvswitch upcall is
> decrypted in place, letting an unprivileged user write into the page
> cache of a root-owned read-only file.
>
> Propagate SKBFL_SHARED_FRAG when frag descriptors are copied, as done for
> the other frag-transfer helpers.
>
> Fixes: af2806f8f90a ("net: Export skb_zerocopy() to zerocopy from one skb=
 to another")
> Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb fra=
gs")
> Cc: stable@kernel.org
> Signed-off-by: Zizhen Liu <pointerliu@126.com>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

Thanks!
