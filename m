Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794603588;
	b=JtW9MELcmvAj8QNp2nx2RvzUWpuT3vDW6t5FGLe8/7hgIlwcCd4lzVEOgy6N/rGtrTxX
	 bRJCJN7CWM+lZGOj1Hz7oFsrtko8quJWc7AbL35dS9akRT2MV+583f5jCZuITq7OExfcX
	 OAaxr5SIb38hboaClzXBA3v/9fMy0YQmcW7WqEocg51E1qzMU3+tDZcEIjuxfOfXCPY9P
	 EqG/49jT4aBZACQOpN1NqEJctXbIgVtH1374xIafw7j5hmdV7jT5WkbhZhKy/2rgxe7tM
	 5sP4VmvB3vnO7GcVseAC7N5+/iH2RG8SYsO+ZmkszoY4aPtJRRJCIVkCENm1cv1GH1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PVwzuTDO0V0WU4xCPVDAbIib6qSF19SkXsHbfwUAYmM=;
	b=L3cVhz2U9LQx9VF81KVV9ZdvxLH0GM1cw5XdA/t06K9iZia2lt8JcUkeWFYeas5hX2na
	 k6OznyIEt1aTuqjwUUMQd67XdTZmifeCJ9W7mbi0+KHzdZzYvst5hWIhVUfmjIHsKlFeS
	 6IQ+JK5yuRGUj4qlU34YfLqr29xMWYw1F28Ftno3bfsJ/Wa/ggylQ08n3r7TLvvPDN3zl
	 GC6+BMHvT8Kiqc3c9eWO+zEhqk4I9y/deh/M+hZFw182sCvUtwyXQ5pdgzuIfB1WHiWMr
	 PTMr/VyFZzrMSf9PMeO1kLFZZODuiPsXkDU3O8AqK1ENG156dWgGduv4lIAO6o3fk/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hOHmc9+K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A613C606A884
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A613C606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hOHmc9+K
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso313a12.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 12:59:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794603586; cv=none;
        d=google.com; s=arc-20260327;
        b=GG0+IussmMJrPmZLpSAXUISms1T2VI5ExVbjfxQFlOGl2WMM6AMmbr7zkJFT/h/Qa6
         KuA6fU+6dGCmnrDE4yQIAg4EpymPUIRaHWYfrBI0d8KrEGEQMxs4XioJjC79Fl1ISc/W
         bDmI9SPqQJXi+a18TPVeSzhxH5i7Zx2i9q5nRvnsPByPRNGLuJGBMj2rn9vjvuBngpKo
         GOQ+nhR54+Qa59/HcBeLpzFBB6+Ywzla1jfEgDPvpFRqSEDm7QepVVxnKpHazV/hWVH9
         xKlo3GOeNt/qNoh40KH1JrwaamAAJ/qU+LgsucosHfG/zLfhHiRwaJ1OJmwpjDCVgS5k
         V2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PVwzuTDO0V0WU4xCPVDAbIib6qSF19SkXsHbfwUAYmM=;
        fh=E4bugEy3xpS2NkiBSOgwLWxQXVlouGwofDJ9vg5sgtI=;
        b=TNqwxIuL8NXl/af4iDILA/ssPuWiE0QIwaJOrU4CnIEvwde1EBb+pM10g4btVM32g/
         BpWtA1IPWc2/8zVDVHRDl+aPIE9V8W5cU3L71+kk+Ra5bZMVJaKBB/5DTAiukWiQkGa4
         V7l/NOyaEpdKygyhQKVx/idprMz91GAvUqoCr654TlEaPbcCUVpJGF/JvFxVKvsuryJ9
         qxXgy69Cssxcf//S/sdWisQb8QLLT1aE74f3JwcbSsmV4fJGWo0bx72UcQ4E95Mmxppj
         5pJTg2KvGrEgHZhCXsQXQVd5uOpSLfYgQMP7Kjd8tiJDylTelHpXos+Wl0SWjXx8ZSjC
         CfOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794603586; x=1795208386; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PVwzuTDO0V0WU4xCPVDAbIib6qSF19SkXsHbfwUAYmM=;
        b=hOHmc9+KqPvBvnJdzC/LRFJah8sA7xdxNc8h8aP+VpumV1tSIp+CrQkmF/B3ENgKqT
         xqA8FZCKCxhZVE3144qByWZmwp4c9sZD4pz3fnAPj+B/NX3XdhTX5m1e2BL2bBw18K8O
         kIcW4nDplJInC3Wdj+jWDTvUhBa5AiVJK7dGrVx0O1aXvW1X0aO9do7o5rMcAo/ilQ1H
         TiB6OYxRQUj/XS4nz145PP9Y3Z9Hqjg4WqFirv0SoTCxSpE9e/ARdy3zKdeOkaJpxrUJ
         uhSiEls3TlYRkLP7l5x/S888JM695ZzodpQJBMoEuVhQcbJ+lMF/xNC8H24ij7YXxH+G
         Na7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794603586; x=1795208386;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVwzuTDO0V0WU4xCPVDAbIib6qSF19SkXsHbfwUAYmM=;
        b=pm/E0IfoxopCnPnXIm2iyxDq+rTd3JOWenzpWDNIuyzGNJQpYkQ3JiCuL/tcqbws+T
         vpWOTdudtdQ/b5ZmDdAhP60Nf88qZEkVRdYFmAtM3UcK1nkdhWlVGjWt+fsAknzoRJ/V
         R0TdczuYXnZt2y8jNb8AL7Rrm/LnnHzwZMuRi0UP5jrRk01TQMxqYFGiyB5ucFJH0Yn4
         h0MMugpXyTTHklUSFoa5IB4dexg3DZFssnnBKvWxX77OB59cyl0hoLec2VrHUCcEOvCp
         1PdvhBz56k3UtV+mc2U3AYFrbLsg1Eth/MdRlCEOqVsSTFh3r0/FOiw6dpkmpjMRFala
         pirQ==
X-Forwarded-Encrypted: i=1; AL+hErFxh4f6DnzWGZrTbXwLeoeN5y8e4Mwbq7I70f9R4+CxL4UIAcR9t9lo/HBdZ/HPFumsYPisLbo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1PENPpWIPMvsj3IoqiJ2Akq6Xjah55pHI0dXqHx6YGtLVNhY4
	ZchD9qzTwfB1LwllC1z3xzIMiAP/+OWLErJ7DAlmt3Lqlv3m2HIdNPYYtPOmWpDpMkA7bMl+1+3
	zo0OYa+M0tWnOXHTchsaXsV2u0QU5gYLdpJhNddXv
X-Gm-Gg: AYBFou2Cczjmd3Zo+dwJpr1mgZ558sV9AInICrKRo9+/Vt7c5GWSFXKE96EgnuQCwtq
	ZdfXDrPfQ2rOCaHcHGj6B7832HLfSLwz9sNZgl75bnJ8Qs9AJ55c3afU/szuosf4PH4JZkioAaQ
	daoN1m1y5sCC+D6mMJLWMkEKcPip0VTKLfj4zZ8hKEYYreLxJ7V2QB8LJIERgC6KYauf/dfa7ZC
	lO6+b1WsBuGBd1sYkgdVRoU/FDdDSQDjJSjJzDWLV2dvU688wJ8nAdMPDx9NhB171GyUTd+I9gw
	Jo9NiiDzNz9iR1gQIfArNKZoSPs3PvdqwcElhwEGeCpGdUPlgz3vvpl0TAoHCjt6TBn7NeXhskk
	Jq/SEhIbBpgbBmKT0h0ycmyNmDevuRhCAviEl9Ma6banNNQFlIGkrtq7CzEOCDK50Fbw=
X-Received: by 2002:a05:6402:a209:20b0:6b5:70a4:c77c with SMTP id
 4fb4d7f45d1cf-6b7e4cf7859mr4733a12.11.1794603585731; Fri, 13 Nov 2026
 12:59:45 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113101109.3227815-1-arnd@kernel.org>
In-Reply-To: <20261113101109.3227815-1-arnd@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Nov 2026 12:59:34 -0800
X-Gm-Features: AclHuK_bY7C_IwYzZFeSLAm6EvkuqLy8iUU-z8m05Hb5atej3z-uqwQYYqikjoc
Message-ID: <CAHS8izMEpOGj4bZYPHJW+WTnSYwimw6oZAK+B7JVPkrmf75a2g@mail.gmail.com>
Subject: Re: [PATCH] net: kunit: move struct net_devmem_dmabuf_binding off stack
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Wang Zhan <wang.zhan@smartx.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 2:11=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The net_devmem_dmabuf_binding structure is really way too big to
> live on the stack, and causes warnings on my randconfig build machine
> with a reasonable per-function limit:
>
> net/core/net_test.c: In function 'netmem_ref_test_tcp_devmem_recv':
> net/core/net_test.c:1720:1: error: the frame size of 1744 bytes is larger=
 than 1536 bytes [-Werror=3Dframe-larger-than=3D]
>  1720 | }
>       | ^
> net/core/net_test.c: In function 'netmem_ref_test_skb_segment':
> net/core/net_test.c:1477:1: error: the frame size of 1584 bytes is larger=
 than 1536 bytes [-Werror=3Dframe-larger-than=3D]
>
> Since the binding object is never used concurrently in multiple tests,
> avoid this by just having a global copy of it and reinitializing it
> for every user.
>
> Fixes: 2285346afc99 ("net: kunit: test netmem, page_pool, and skb frag re=
fcounting")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I don't particularly like this workaround, as global variables are
> always hacky like this. If anyone has a better idea to avoid the
> last stack structure, let's do that instead.
>
> Without the patch, I run into this every few randconfig builds,
> which did not happen on linux-next before the merge window.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


kunit_kzalloc() may work, but it requires `s/binding\./binding->/`
across the test cases. Either way is fine by me, this minimal fix
works well too:

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
