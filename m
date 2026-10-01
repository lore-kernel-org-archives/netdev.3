Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2084B443C3B
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790879694; cv=none; b=BPTJLQjXWv7S2Qb3iGkDDIG0s8d/d7CNC/9gnC56eRTWG1OsfpXprJBRcIi4RWka53/71FyWT4AHzv546u5rPE/J6G6MTrW95UfJ2XHvbV0KN3/6LLnRHJkLDTaktnFAgaMOz5UQpZ+27LPnpR/1JPZgoZ3lGEt9huURDgIEhKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790879694; c=relaxed/simple;
	bh=HOUb15N1qJm/O9C4sSKpbJxURWaI/1QGA2jspzXH6tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GObrV3oT6uLv/KVsA3BT0kZL4C6lpX5c9Rb+jgebEGmjilFAKhR2WC5cQ3VIc6i2xY7+Dlw4hkJ8vpi3JcN7fpP8xRJAAK8w2C1INHL9Y06UbHh9SUFT+SW7Cvdi1KFrbGlzf2lwI+CxuLJd8trWGksktxYRXtNfj++fVscgb5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ba2vxY0r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ba2vxY0r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9ACF1F00898
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 18:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790879692;
	bh=zo6B0ADNEIRm7se1vRwOte6tO+idRNIvyVrxyssAbvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ba2vxY0rm75u23eS1nrjZmO5b3c9HsfQv4e8Eu607pR3Ld8H66AtZpHo1w+FutLPb
	 Q8LzLnwSiGmMeOgceHHGZL6GvQ7VBbJrV40jdAPJ40skO+dUOvF0ynXb5CaKhAgRWR
	 DIz1QKpK+YT7LFrcEjXs4tn7aNoi2ukJPaUBp9pjpV5F7Z9YRnJ7X+drFzxJ0IAawV
	 M0XlOnubMH8YcODFTHKtSXm+f7qS8Xp5RE+dRs4UOkrdH9lezmWKYxRUsoou+sQMC+
	 kCoHAzVVhIHMqXQRiwqvj5kJZqP9go3imYANtRiY/OaZkNuhXio/hy1QPQyOXs56e9
	 DZmBWu8DTvNDw==
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc9ab667so5720090fac.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 11:34:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzFHdlQvLiH2QIe2lfc7TRl9lN4/O+6xolhmWSa4M39ivlSdJh/pykuuNE+ve3M9/ceN1t0gCw=@vger.kernel.org
X-Gm-Message-State: AFuF++miwiSsHYZSvQiLdjA3Dq1OoFPcjLnRb5v5q8VYr2XGVZH9ML8x
	e4SAi0Pi1YVD+vpWYtyRbKldF4q/B38tI2wndmBsB04YauBINI2snaBnq+9daXPk/p3vqZw1aZC
	B8Yr4FDXhDkTE7h65QPXiz1uU358vIck=
X-Received: by 2002:a05:6870:b48f:b0:49d:c502:5e2c with SMTP id
 586e51a60fabf-49e15ee8a14mr384544fac.48.1790879692094; Thu, 01 Oct 2026
 11:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928144254.3361044-2-edumazet@kernel.org> <179087712222.434549.10051297010561024620@kernel.org>
In-Reply-To: <179087712222.434549.10051297010561024620@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 1 Oct 2026 20:34:40 +0200
X-Gmail-Original-Message-ID: <CAL4Wiioejp=DdtbxQN6wEAfzpaO10ABJepBVbHKoPLVuetfiDQ@mail.gmail.com>
X-Gm-Features: AclHuK-SAsBRofYU7yooGylmOW6vU5asxW5s_idOhujtga6oYSPc1BLXEUH2eEM
Message-ID: <CAL4Wiioejp=DdtbxQN6wEAfzpaO10ABJepBVbHKoPLVuetfiDQ@mail.gmail.com>
Subject: Re: [PATCH v2 net 1/2] net: always dissect GSO packets in __virtio_net_hdr_to_skb()
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	willemb@google.com, mst@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 7:52=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (1) =C2=B7 Low: 0 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] `__skb_flow_dissect()` sets `key_control->thoff =3D min_t(u16,
>   nhoff, skb ?

Allright. I will fix __skb_flow_dissect() in a separate patch.

pw-bot: cr
