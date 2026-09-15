Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3A339E180
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472951; cv=pass; b=KfpRAMB0gkm+EZyvIXx0WmzS0zKXFS3+iQ3Cx19RzRWYWALDl9gXxW7NnsPo4Mw0XSo2SFSdPWxLlHr/HZ9cPIb2SHPaQNdT9iXBZhoTIpl47WQLQAZ9EVSTHWwUYw8l1R8hoXBxKmZuNnEQprtxp5rrETmWFcXEzm7I0UPxHYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472951; c=relaxed/simple;
	bh=EKhOdtc2ANRqvMTZGW8bcy1X1CMnIUmNmvotn0d0Xbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLLMBQSya3dStWoWCTDsF1gLSPoKJu+pEn4dqd5rGNwpC9iO+H/LIuCba05miAaaRgcj1Uf2x0Fwzw6sP1R5USMr7GHYCwSful/T9A+FbWZD5gf7jCUS76ZHKjcNTj8q+QZSspDZMiMFhMNaev+jxeUHHE7Gor+XXfqED+xby4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y8t7Y3/v; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y8t7Y3/v"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530e2f50d01so38036541cf.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 04:49:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789472948; cv=none;
        d=google.com; s=arc-20260327;
        b=R6YCEmKU++2M6AD7lUHPCb++hwl9D2xWEA72NA8XuEx1c8YLNNgJw4R4kyc6/Ljag8
         ODJjQRs9dZWMAshtgRmEztqGbw7AL9o1aRnn6JA5G9eARI0Yn/TSl6CY135HUPtZ8XI9
         urrfPiagLgUqwJv23KWf4c6XEb2ol4/H7T794n77Q8LsVyYxUEiTs73QjrCqk9rfRnyH
         OhyT25Vjiau2y/q5zwA7O830E4NOkT1cgmJ3A7qkpiyM2tc+D1iLjjnUl+mRbhHJgbuN
         zeI3lLG5znbTM//fEOYkTRI1EwXIjf3gAOa25OLOcwOkWvpxwPcWlVEzZx7+R4/vz360
         gZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fm0ZIJs37ii2Ek6hvtIpnQ+FAT5aU3w3jOCegQu5iiM=;
        fh=9fUlFnwFyTZEKpszFudtR+hxTmZ9yel5BFGHLemcEIQ=;
        b=sYvaEhu1Z3oLJKfaibVeJTqvYT+Mh3mf4/uwCtSw5s0jOfkknUtRbY/FOR34rYpPlN
         OjF7TABVxTKQ7qgFPNA1ONfXye5jaAKb/Ujth2iBzWkVRPAazyMG/PcZv2ia6HPHnXSO
         SXovhllJJpAcG80hcd6jzv74ZfYoFhBS3SKsLaqd407rfXTGpiRJ0Qxre51/6Mqno2op
         zU/PlmAmYUPRro3V1ve6d8kRtBwhf/V2AYgKPpeFl3KlWM4d3DS+7YNG8BBeiKt7sKq/
         tW9MOZQC2Qwnf0IKmS2yEoYufnnPbD7G3TRlmQMhtHlsWOLwjuEKU1244JXeWfdxB8TQ
         jjgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789472948; x=1790077748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fm0ZIJs37ii2Ek6hvtIpnQ+FAT5aU3w3jOCegQu5iiM=;
        b=Y8t7Y3/vw2f8VFqKRtrwwWBPlnHNrl7IdikVnPVQmlxBcMicHC5vh2dVI/bkXo7N4j
         RDBSmSp9p4GFs4nNYGwOOGyGFFVkyq7PDivRhMri8qLqv/rLACMVxTiGPRt3COboqfVc
         Z9KOsUAzTFLDfRN8eLzcIRe1L0jQO6jOMRpyydJkOZ8e1VPmBQH6A2VoXENfW7HEVbM6
         t+DsMF9VTtoFpqSQo3wkW68VnvMQWCta6LIGVaMhKtZVuhHHOaIH1CS/PozlUwl6nyzU
         DddgY4VE0ik77PWpr9iXoyyTOk14hKJFULap1/Qs2c1L//P3vv24Vj+Ua1CRTOuQ2Pdp
         KutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789472948; x=1790077748;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fm0ZIJs37ii2Ek6hvtIpnQ+FAT5aU3w3jOCegQu5iiM=;
        b=c/XjFMlvge/J9rkKJSHKafBf/Mx8yl7XVGak9x5GTLjmC1HsEJD/ZBx7d1JniEzVwi
         UPRCQvH4zlSBFEkhE5C/PxWYNnGfz8Os4qELZSZ0AD9Rwrhr07q/4ojpwDwPx96FFDBD
         wM2e4nUafwy4ZGpsqA9Nj6R6q+jtPOlgoA2A3ctk1ukTF4YoAP/Fida/QUQ0IC2uGxZ8
         6cyhtcGxGH+LyRaPxs1yAS8X3n6Pa9AZHq2OPLpj+3iMfcR8PSlhCLxBdXVU8CigumKx
         BZmYJ1J+jMq9gnHRUxMjearZyZtlM40P2GN4gA5qCNVcJUcXEFLzdXNWRblVHwM2vSM+
         jigg==
X-Forwarded-Encrypted: i=1; AKwUvBxX3vpkVIZzxJUGcPuj5XC9PFmGiCIZeYmybVuIA15FS5tCW/6QFl5EnJymuM94GtjRQ8Xt9AQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kkgtmLbA6HXePmm890I/yTcP69k7C4+ue0eWYCHMEaf0RbSXl2
	dJUgq14ZifdbtEeH9yP0HHQKfNe/d2rpr7VHTocOTh/u7Lcj6beTFR5fb52B4D7NG0/7PGvumrF
	oko/VWLkXPxtSAHrlEMGWDWhp17yByFe5AAMwdKYJ
X-Gm-Gg: AYBFou0sQrcJMJwa79oZ6SX5CN9bqhzqwzhd2ftbu4ci/QxkShg1LpjPW5Vlmyfbf/2
	jaM1jbXFBjsoDb6jbTZRBAVhg14Z2dNpjCgfqbN0ZKzs97L1Mu2fFkxZqQ9eUU4aVVTMegqp6RL
	yiK5CwZy1ZCdjndwA0882t+vW+zhsvSQm7LhnFoeYqQrSV7I4zBt//fv8oK77/ooWUFjZ3OISia
	7PxBQHUB29bgE0ERZOmMwVVf3AkMEqiDPQrUlb+SJKUJ0dDm/FxUxNfXlZ7k81yycMBcom2ALnp
	PIzdB7IYEY3FES0E5jdz+xY5RFXI5tLrn1sIXjJ01GrnB+JsMfsVKYu1PXiRxPfP5V7JRj+jV+G
	dK67Iun40AH2DPT2wv/ZuJV6fSkA2+2PXHYUrzmS/BOOgAync3EWW7YE8afF6cb/F/8s=
X-Received: by 2002:a05:622a:292:b0:51c:1a46:9148 with SMTP id
 d75a77b69052e-5310d02e5a9mr94721561cf.34.1789472946463; Tue, 15 Sep 2026
 04:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911062200.231316-2-edumazet@google.com> <20260915020009.886579-1-kuba@kernel.org>
 <b22f3b29-dd7f-4c9d-a975-a3753d41efce@redhat.com>
In-Reply-To: <b22f3b29-dd7f-4c9d-a975-a3753d41efce@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Sep 2026 04:48:54 -0700
X-Gm-Features: AcwNN1U96G5EXqvO99begPsAUYZmhYqZs2453ZO3_b2YUPgUqqfPGIB0AWmq8zQ
Message-ID: <CANn89iKLd+Le=s4TK+Eba03s=hW5_zWAiQHD5NZ_Bh7sgtW+Zw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/6] vxlan: vnifilter: use list_for_each_entry_rcu()
 in vxlan_vnifilter_dump_dev()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, horms@kernel.org, 
	kuniyu@google.com, idosch@nvidia.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 12:53=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 9/15/26 4:00 AM, Jakub Kicinski wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > ---
> > vxlan: vnifilter: use list_for_each_entry_rcu() in vxlan_vnifilter_dump=
_dev()
> >
> > This switches the vg->vni_list walk in vxlan_vnifilter_dump_dev() to
> > list_for_each_entry_rcu(), clears the saved VNI offset on the early
> > return paths, and adds cb->args[2] to track the ifindex of the device
> > currently being dumped so the VNI offset is reset when the device
> > changes.
> >
> >> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/v=
xlan_vnifilter.c
> >> index dd94085e08865..0a18c32902da0 100644
> >> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> >> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> >> @@ -333,22 +333,34 @@ static int vxlan_vnifilter_dump_dev(const struct=
 net_device *dev,
> >>                                  struct sk_buff *skb,
> >>                                  struct netlink_callback *cb)
> >>  {
> >> -    struct vxlan_vni_node *tmp, *v, *vbegin =3D NULL, *vend =3D NULL;
> >> +    struct vxlan_vni_node *v, *vbegin =3D NULL, *vend =3D NULL;
> >>      struct vxlan_dev *vxlan =3D netdev_priv(dev);
> >>      struct tunnel_msg *new_tmsg, *tmsg;
> >> -    int idx =3D 0, s_idx =3D cb->args[1];
> >>      struct vxlan_vni_group *vg;
> >>      struct nlmsghdr *nlh;
> >> +    int idx =3D 0, s_idx;
> >>      bool dump_stats;
> >>      int err =3D 0;
> >>
> >> -    if (!(vxlan->cfg.flags & VXLAN_F_VNIFILTER))
> >> +    if (cb->args[2] !=3D dev->ifindex) {
> >> +            cb->args[1] =3D 0;
> >> +            cb->args[2] =3D dev->ifindex;
> >> +    }
> >> +    s_idx =3D cb->args[1];
> >
> > [Severity: High]
> > The commit message says the ifindex tracking handles the case where
> > "devices are added or removed between dump calls, ordinal device indexe=
s
> > can shift".  Can this new check actually observe that case?
>
> I think this is the only comment possibly actionable. AFAICS addressing
> sashiko comments for good would require a significant refactor switching =
to
> ifindex based index. That in turn feels slightly overkill.
>
> Possibly implementing a nl_dump_check_consistent() check would make sense=
?

I started looking at this and added a patch after the first one to
implement this idea.
Thanks.
