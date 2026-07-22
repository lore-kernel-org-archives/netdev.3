Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2220A2D7DF1
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719898; cv=pass; b=Q+D7uaMj3hyuUEuCUcuH0Kmjdthcd51upGrqNEqiqURx903a/C4LE5p5ihnTIKxetjEAV1EM73GlAvS2R7I2YYlFAihnfxBHSHIFHRUvjSOnLKhm6AmBkIX1K0u9WT8+WC0MS+rxShck2lrGBYwgeqTRgigAEmTYEKx32iTzbdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719898; c=relaxed/simple;
	bh=xBxSszPrdvyPtWwG/4+6rb+5HbJaMyzlQVfk8xogBCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJLWfPhXCTDNh+iBifAeHwCT6LEWAQ6z7TqkefX84a4Vb3+fuw4xtGR/cYa2Pdg6hh3PmbHyOM8n3mBLXSpvL6Fk/tNpr17zGW8bjeAcs3eIq5c+o5S4Xgo3kdjLo2AyePuQt19jq30mqEMZyxVnZ+fhTPrzobDm1/BIF7N2eWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDlEduFg; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDlEduFg"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e57a753f9so1135432685a.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 04:31:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784719892; cv=none;
        d=google.com; s=arc-20260327;
        b=TEFXZ3RSV1FPF4E8a744dNzP+htWCo665b845ljqffBFuD1+Vlq5ctvUsXfdc0f7NX
         bRCQW57YO/sBezalZTvuc+2fc31RI6cAa1C8bOlZa7jk65YlE+QiJxBqja3baCghKQBT
         +7onwiI1LaHEUuYpT/bXTnP+C/ZkDsaHouTY7VeET7s+6XxATMuUQ+VGJUHDRAAsjasp
         XFnw/hGfxk6uElIkBVZSu1II0jpubbSQ6Dm85Eel5m9VByn6eAlUo83NmLf3fPyoPlRs
         wh9OFzwSyjXYBcd60DavvTchefmWip0KIbJQMl420jGj/OheEmeEMses01jAytuVOXsJ
         xMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+AjNNGtU2rNOL7AfWz0JeUtzDJD3qx/w0PKZLpgVujE=;
        fh=gBmikqasyjvO6V//5AphK3IFux+Vq33YTyjbq3GAIyU=;
        b=PMajM5HtdX/rhATIbKtNf5czLSsLj08MyREL3os/2N8+VrdN5QsuprMBue96FspxBJ
         rFZ+v+MfeRZlL2ZsufSjMZ6gyDZ0iTqs3PXbNxvo8KMX/xbAyC2TWci/fGfzq77zyUfH
         ntcQsgeghnVSISydmpM7HcTs+rQ9HkLP4twpzwfFAaWS9MuMq3GMG9b0lNmtFiM9OmXR
         WWcwlisvzrIDtWDnl1rNSiqQnCYSxoHFsY99MiJNuC+b7XVvQerUUajm6zhdhuSQcxTK
         fmn5Qldw5b/IcUr9M6kfSBFh6vKBfFTzyUQ1FFMGYxbs1Y1zJoekvlnJTT4Ak9K6rv2c
         LVJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784719892; x=1785324692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+AjNNGtU2rNOL7AfWz0JeUtzDJD3qx/w0PKZLpgVujE=;
        b=gDlEduFg580BRWayZR7u2B7XnkVuf2HrGfXpZfR0Hzt6w0JNuhRnajfp7Tng/tsPUz
         Z0B2t6a5OXtFAWqvEFr+RRGknQNqck26r1Tbhoz3myitX8k368/XtAEz26n4rwT71oiD
         +1z3DJBf4n5WuEH2uqrrLMdqkFUVJtu4RBXxBPBz0zBFVd8OhpSgGFDwUTbabfIwicgx
         OG7yj9n0qvR3nNWqXdik3gqvpHS8PlEAPFIengCzH4eqq4midZmSXqBuRHcHVjoDc08x
         fnnvtfLJOJEDx5AjPu2qD9prA4n+5LssfxIb7NSFvQ1Ey0+JvIAvp5LQfFGRJ35mzgdW
         /XKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784719892; x=1785324692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+AjNNGtU2rNOL7AfWz0JeUtzDJD3qx/w0PKZLpgVujE=;
        b=RoyKlEhlW+ZBI0vdBwJ9cEtWxGDuL86/u0nHitNKUi82steIkWrDrReg2skoPKuJ6n
         f20hwykziwg+e885ujmfurlWuZnHf8Syz76ZPOPFpUrsdFPVJ0fYXtQ0td0Vr/RGM7If
         BzZKr0cDBfdjtPgXottUh05iv/2fvjJbzGpaddDpqrBEPtK+6JPW6RF7/wP3F8HIhE0B
         hjG9/OJlqaBIaNd08jh0/y3R6oMFONCP21aA7mApcrZcX+9ypW83B6NwUglr+i0F9JmO
         9LdWDy7GfCmgGkuL6U5fTiGWsgR256tZ+pArJcKGUPfYCP4Y2R3mA4QizKuMseDIILCf
         JgTg==
X-Forwarded-Encrypted: i=1; AHgh+RqB1zVdirALky1cpA5K5+B4T3Nj9Zbzx5939WsKMEtPZjQqHp1bG8ksauF5Y+I3lELbRj6i9pw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk7HDlSKn2yJfIqQn0m0Lpql8O26hkTOnXC/EHYY2USG+MkGVP
	pgnZrSyx0Ghnx8/TZaYAFxxYiPD0Xw9tEjIvOUR6u4ba4y9knwsdUyi0m0kf/aswaCPhuS038do
	emxtBIal4/mnOZvkIvJuanWepJhUlI+k=
X-Gm-Gg: AR+sD10hlFGia68WzZJbeQAv7wAb6SMGzizOx6QcAQDcHAOkvZdvHf+wgSOc7GbA7Sd
	GS57exOc7/pyQcadYMuGDj1hqm4sCRadCwQgeIhp5u/oVsqKeYZtDP+QMNTbvPKamMz3lQLGDq/
	pWCs27Cm4EDHY0O6W2/BD7SpbQ5MFHYOnCclPi24cS7BZwG9Zc1qM26b+33m7ZQ4dV+FXX4mB9l
	+nw+MgmzO99Dkgg17Mxi+hXlis07UpuZDIeXYuJzy3hf+Y1ifywYVGpw8zAJoFmqfYA0gxu
X-Received: by 2002:a05:620a:6187:b0:92e:c117:9ea7 with SMTP id
 af79cd13be357-930b4393bf8mr2076258285a.85.1784719892325; Wed, 22 Jul 2026
 04:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780458440.git.bronzed_45_vested@icloud.com>
 <81f26b8fddd59ebb6cecc417fb138d9ff5214e08.1780458440.git.bronzed_45_vested@icloud.com>
 <178471846217.973832.14121853580804517391.b4-review@b4>
In-Reply-To: <178471846217.973832.14121853580804517391.b4-review@b4>
From: Yuan Tan <yuantan098@gmail.com>
Date: Wed, 22 Jul 2026 04:31:21 -0700
X-Gm-Features: AUfX_mx8xqt1uALeyrzL7k_-AEqvUGxzYUcmdR3JYr4FcqhIKM2SAr55rEAlxo4
Message-ID: <CAPuPA7KaNrGZBO0LpgHJ=cwSH882D-Gs6bCVput3gyrhTubTFQ@mail.gmail.com>
Subject: Re: [PATCH mptcp_net-next 1/1] mptcp: fastopen: only mark MPTFO
 subflows with SYN data
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com, kuba@kernel.org, 
	dmytro@shytyi.net, yifanwucs@gmail.com, tomapufckgml@gmail.com, 
	zcliangcn@gmail.com, bird@lzu.edu.cn, bronzed_45_vested@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 4:07=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> Hi Ren, Wyatt, Yuan,
>
> > Passive TCP Fast Open accepts a valid-cookie SYN even when it carries
> > no data. In that case the child socket's receive queue is intentionally
> > left empty.
> >
> > mptcp_fastopen_subflow_synack_set_params() set is_mptfo before checking
> > for queued SYN data. That made data-less TFO SYNs hit a WARN and, if
> > the warning was non-fatal, left stale MPTFO state behind. The stale
> > flag could later trigger a state-confusion bug in
> > check_fully_established().
> >
> > Only mark the subflow as MPTFO after confirming that a SYN-data skb is
> > present. Return quietly when the receive queue is empty.
>
> Thank you for the fix, it looks good to me:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> @Netdev maintainers: this can be applied directly in net.
>
>
> Sorry for the delay, I initially wanted to understand the reproducer,
> then wrote a small packetdrill script, then I lost track of this patch.
>
> As I mentioned to Yuan last week at NetdevConf, it would be great if the
> PoC could first try to use Packetdrill when it is doable. For example,
> in this case, this packetdrill script appears to be far more readable
> than the .c files generated by AI:
>
>   https://github.com/multipath-tcp/packetdrill/pull/202/changes
>
> =3D> It is easy to read the syscalls, the injected packets (<) and the
> expected ones (>) with an output similar to the one from tcpdump.
>
> Note that for MPTCP, this fork should be used:
>
>   https://github.com/multipath-tcp/packetdrill
>
> Otherwise, the official repo can be used:
>
>   https://github.com/google/packetdrill
>
> --
> Matthieu Baerts (NGI0) <matttbe@kernel.org>

Thank you very much for your review. After receiving your suggestions,
I asked Wyatt to prepare a packetdrill version of the PoC for this
bug, but it is not ready yet. I apologize for taking up some of your
time on this review.

For future patches, whenever possible, we will include a packetdrill
PoC in the cover letter and send it to the public mailing list. We
will also use a new Reported-by: Vega tag instead of the tag we are
currently using.
