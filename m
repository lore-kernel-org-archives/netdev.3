Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFC837E5DE
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473591; cv=pass; b=p1zprJByHT2Hy8GVJcH9eGycb3ZaIoFZ0NJIvuJrjVeJBwcdnO5bl8pULnJyysdO1k4rBKkkggpXvGS0dSBd5t0Acl4lhOUiuwQbImCkSVKKPXifuD/tK95L62wHMHh5P0gLBDkDRtGg5CMIUjfQoUqMWxI2ni8UnjfrbVkSlUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473591; c=relaxed/simple;
	bh=3K+rgf/oCMhDvVggYvh9dFePmAGm0zPjujux7MTkeeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfXQ8SJhF+fKlqpYeSSjMoTLIdMoXnTCfLoi1loxfWKW8I5V49+i/u9O4XWsJ/n5/fb7rUNViWb2wVxfCcx0MpJT5SfRFrTEoV47TSqedGCyIv+FzmZy8CJcXRpVGCWapmWJV3/mvl7K8osIqCq2c/1c5nLXcy6HIMqb5FG4NCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vVSyztMS; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVSyztMS"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e88b60121so219689a91.3
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 11:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786473590; cv=none;
        d=google.com; s=arc-20260327;
        b=AzYgUMoV1/2CIKeDzmCNgUoOrjN22LYN4yH37MleSeEsXPDvBrlMR2S+h0UcUn5GCL
         AVs4Pq9yXzfAGU6UmmsUGGjQukDjFgR5xWL1YEE0Aza/pwxWdsderRWnvmvtoAa2y816
         HQ24nCmHBbRaVDYJQGOq/ecxCEf5kjiTlNHyWUqek6Cbt516U53INcjmsaLoFK5R3EN3
         ZzQWnvB1tn+6qyX34gg1uFc82YTyA2Zb3n4B4L4+RQ+jIggdPAZM1uXWK2yjyWJyrNvp
         QlZYjFEo1UduccxMpKS23QMebe5fp8/6lJDe8005W0vDuP1xux/hLa9weQa8ytlFS7Q6
         gNCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3K+rgf/oCMhDvVggYvh9dFePmAGm0zPjujux7MTkeeI=;
        fh=TTgZChjXrklxbjzyDzl8jg6S6Vno/0MQzvQcrHuPp3E=;
        b=fz0QR4XMs0AIitPhFF8fjWx/fyK5vFmxbNNXevTUVEanrrG2B0rZnEdVxcWkFosHAl
         YFa0rgtq6E/NCGTV7Vgyz+1MNxllo11ndmlIbZveB+1VId8u7qkNeTEFisx6SCzaIcI+
         3OP5Kuc2V/HSJ+dM0/lXTBqtvuQ9GT0L/+BG9eFF2gqYOanz5Q+J8RuacKVRY2iIxS6G
         uzzMgFR/tgUegrZoLVtRVTSzMBg91YCls0N3EdJKGyUzVb2C206BlHMKe5m2+TMWXq6m
         yXrBSDuwNqf3GRtsaDuV142jpHWuKqU/p/0Az+XBS3yuAo1Bp7v4mkmDZHMA9GErz3Pw
         ieGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786473590; x=1787078390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3K+rgf/oCMhDvVggYvh9dFePmAGm0zPjujux7MTkeeI=;
        b=vVSyztMSfrZX71aarozZiKqjLOJrIniup5D5qEKlaPZknTD1CoVfEb/GZWBAVu1wFn
         5EeGtpN3RRfq6N2Iz9GvIf09YwtznRbG81goiudagCtNB86VWd9NjH1EYZXvd1n+NR+U
         oqQwAnQKmYAjbdzmwPwpbiVq5rwfrlsMCeHCkhWKj6cGV/MK1/5Qa6ROaz4Q7KWAaK3Q
         kUjP2YT9Na2YFPLq7mCs20DnwLVrUOVA2jgWeW1zEDes2iy4O000V50UbV59WxbDBsEg
         WL0D5idRSFEV4I9swfRztMj8LCDKk1bQE+aw3UzKzLGgO7QIN2FL+yPFN/N64UnVb4p6
         Lixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786473590; x=1787078390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3K+rgf/oCMhDvVggYvh9dFePmAGm0zPjujux7MTkeeI=;
        b=beD33fvpqRZ+GNAz/VHz2Yj/yTqbSnuEd9aucydoJsSKyo5GT95B50lhrn9ZOJbZiB
         LhU8PjVTFeGDTm3dVJhnQ/X9kvYykinb3qmzxGK2LhtLZS/vnUHS0HzlFlgLS3ryO02l
         gguiI0Ci8KFppkV2KKp7guJAEwzO2RGNbNG3FJ6iEPB+iJEYGCuGtUHN8AXt8uVjEp3G
         PPSENAMihy4rhN7FXWXSBs6zxKF+LqE1xA2a5y7aJWk5OQ4qLQSQklNEVGKSECSaFoN3
         x8Y3NmNQDprkVhhDPpGeKgU3Ey6vwboy8BELCvJW7f04y8EYw5jSH3KTr27kQ6OUb/9C
         Gz4g==
X-Forwarded-Encrypted: i=1; AHgh+RoKVl5G89z8hUqDl9sT/PP5fdIoMKc8d08AACoTRYRtCus4l/ezKQLApKwFMR9xM5V33qlo6GU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywlhMDI2iBBPfysDYDJ7Qo/VgU+FiIo9qVN4OOC5aPRbKCO0//
	3JsfsoeTsUFq3XfCiF2Zmu7fhnfdU9D85VWo4J+SIihinYlFyxMOp4/TeLwLqLImtTF4owjHiNA
	k5/qZ9jTYNUc7qYrFuu2AncrpurhjrCRYfYQhOYpR
X-Gm-Gg: AR+sD12boyNwy+RrCRWW5LZ/6mDs5CFDTZefnGX4oQGayrt678u024556N2nW5HqdFT
	FUoI7KMXFplxRzl/zieYzPfbhlo0Poz0Zv1M3P7npwkC1eaMhdMVtzVwdREmkeo6r/drAlW+Rwn
	GAfeI7B+MGR54VSiLXKuGL+6QW8jYRPV2SpS2cEzSilrXyDz9E5JWUDE0FdVM+b5IuneuUrsdIC
	x7xteJBaxZ98LOloYhyo4uX5Hp1SxYf+YAFAJ4oPAk8+p2kA1etTdM6h7z7xXJvqcTaUPJY/I5T
	VqElZutbe+VXd3pbH+YkIuZsAlDXJafxzfDo8RigidMIYadUVttxAdViftwMa8bXW9qMShmkDB0
	+QtmyouYmOye9WgzfzuCb0K12PcZ485xyPimDq822nPX/hcXfp3EK6BMUKC1Zv2HIJw==
X-Received: by 2002:a17:90b:4c85:b0:381:c500:b0d1 with SMTP id
 98e67ed59e1d1-392ec721e34mr5540905a91.20.1786473589009; Tue, 11 Aug 2026
 11:39:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811022448.116235-1-kuniyu@google.com> <20260811165453.GA3163487@shredder>
In-Reply-To: <20260811165453.GA3163487@shredder>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 11 Aug 2026 11:39:36 -0700
X-Gm-Features: AUfX_mzqfaj4wUaQjRrPpNFoPK17KPzMzlQ39k5FuJ8aDJmiv_NZlqYx3zfp7A8
Message-ID: <CAAVpQUCiW3pPVBCXJjtpqmfkiX496YiMwjpQxx3R8oqpupLvCg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 00/15] neighbour: Namespacify arp_tbl and nd_tbl.
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 9:55=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Tue, Aug 11, 2026 at 02:23:34AM +0000, Kuniyuki Iwashima wrote:
> > The neighbour subsystem is almost ready to drop RTNL.
> >
> > However, the control paths are serialised by the global
> > per-table lock.
> >
> > This series converts arp_tbl and nd_tbl to per-netns table.
> >
> > Patch 1 deflakes test_neigh.sh.
> >
> > Patch 2 ~ 3 are misc cleanup.
> >
> > Patch 4 ~ 7 store arp_tbl/nd_tbl to net->neigh_tables[] and
> > remove the global neigh_tables[].
> >
> > Patch 8 ~ 9 replace the direct access to arp_tbl/nd_tbl to
> > net->neigh_tables[] using new helpers.
> >
> > Patch 10 ~ 12 finally replace the global table with per-netns
> > table.
> >
> > Patch 13 ~ 14 clean up unnecessary net_eq().
> >
> > Patch 15 updates test_neigh.sh.
>
> The change is good, but the cover letter should explicitly state that
> this patchset introduces a behavior change with a regression potential
> (as evident by patch 15).

Indeed, I'll add notes in the cover letter and patch 12 and
move two parts of diff in patch 14 (neightbl_set() and
lookup_neigh_param()) to patch 12.


>
> I'm aware of at least one deployment that will most likely regress
> without some changes in user space before upgrading the kernel. In this
> deployment, the host has several namespaces representing different
> routers with hundreds/thousands neighbours in each namespace.
> Currently, they set the GC thresholds in the initial namespace so that
> they are high enough for all the namespaces combined. With this
> patchset, the GC thresholds in the initial namespace will no longer
> affect the other namespaces and the routers will fail because the
> default thresholds (128/512/1024) are too low.
>
> I can ask them to keep doing what they are doing, but also set the
> per-namespace GC thresholds. It will fail on current kernels (harmless),
> but work on future ones. Similarly for the base reachable time which
> currently they set in the initial namespace to the maximum among all
> namespaces.
>
> Another thing worth a discussion is the policy regarding the initial
> values in each namespace. With this patchset, new namespaces all get the
> same default values instead of inheriting from the initial namespace:
>
> # sysctl net.ipv4.neigh.default.gc_thresh1
> net.ipv4.neigh.default.gc_thresh1 =3D 128
> # sysctl -wq net.ipv4.neigh.default.gc_thresh1=3D129
> # ip netns add ns1
> # ip netns exec ns1 sysctl net.ipv4.neigh.default.gc_thresh1
> net.ipv4.neigh.default.gc_thresh1 =3D 128
>
> Assuming that today people configure the initial namespace before
> creating namespaces, changing the policy to inherit from the initial
> namespace will probably result in fewer regression reports. There is a
> knob that controls this policy for other settings (see
> devconf_inherit_init_net).

I considered adding a new knob like tcp_chlid_ehash_entries to
control the behaviour, but I was wondering if it might be rather
confusing to people in the future that only GC attributes are inherited.
But I don't have strong preference here.
