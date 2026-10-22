Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792681046;
	b=ssXI5T+U+iHHyGHPW0YrDt04GkbwiynZLKG/r4rpplpmTsIynl1AG5yTfkXKpEltEspD
	 yWGNeIUci6ApIE2MYe9SyuZAVk4uJRksP16X2+kCpQemKOy6qcOw6rnCimQHrAwcOJ7rK
	 El+ZI8I3E//MnGzQFt0AYCUhs+nYkyHUDb0/9miqPe5zR0AhxPIC9jG16EZqlmrtUz3f6
	 BF8oxxLvl3jud5FZAEtrIQaUeVDYNPAfhiboINuKY9qfX85qVTzZ34IHqNX7yR6OMuoEO
	 pGsoFuHgzu//uxPjPgl0d+rz+EEakguU0UWiD0jHQcW6NXZfefEqW/6s8U26CSyYV9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792681046;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lSB1/qSQSVVMedalAK+a89GjHY0Aht+HPppY0CFMDs4=;
	b=OIOG3MSrnQpN0P8vMxvUPk0isgd/r5+AwBy1VBEmEQl976m9mc4+H7p1reQckmNHerwg
	 Gd9SdSV5Kc+J+A/6PiTzhcAKppn51YwOdf5yvD7C88AJur6MvAwbreF8Wllnr11/ZFqK0
	 D3cOkRL9Z8Noo8Ne4DJyplEI7c3/Fbr0q4tICRfa9xJ8C6smPfnoiNs8zW0XrgETAC3iw
	 xAZPPavCWQe30SMiFF38ihEUipKAy/UJxZv8n6AdxFaQZo5EUexXX+ZulkqGpXXNYyAkc
	 2mjtQISzG8fTB2ubqFNDDMe4zWkdmDMjM3eyNXu2eRs0DOYV9zrUC+oPgjvtsZDL4/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Spa0GefT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A3E606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Spa0GefT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF95E1F000C1
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 14:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792681045;
	bh=lSB1/qSQSVVMedalAK+a89GjHY0Aht+HPppY0CFMDs4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Spa0GefTgAjge9vB8SL83iquJ2oDN2KWw2R3G9fzs84ZGdYnoKpqD0E0WRFUpkx+1
	 QHPKEPPx++wBzTPu59hvZC8s4TlBKUc9dg6yGOehjRAWtH/KnKJU8WOs9Re9EP8vQQ
	 1rx+Evuw1DjIanV+dsaSXQqanlRadUKfMuWL/D5ylnpYDfB+WNiXOZ2VerSc0wuRj7
	 6YGSyInixYz0Ier+DO/lGxehRL5qAEE4iCknO9k/pnqfC7DQZKL+4W+ts1Zs8lrGAi
	 /xk8DxVUOUtz9O+YnqcZvDxygb2LLjYxhs/lEHiPIu68I9pJcSIBt44Y7JEj+8oTMa
	 0F3BL7FP4d7Nw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6dd4f3f696aso1044916eaf.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 07:57:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx9P6D1OCp721Mjr2stgE5mfxJmVANQ3fnAS5k+G+VzRhxQ6Vfxj/144MI64I/+OoNAyoapl7Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOs0BM/L6Bg4RwkRT3hy2YXas3qFIoFLy+G9vL0UYo9e8Yo4cB
	dydf/Pho6uTludz9s2j436YHrnYsGrrYSaeFT6twDtRQa80MlgRBLHFWAt7xiUMpXp9bGLYax2v
	ZVMUArVsATzrvLHOcYPhujzVssa3mZIQ=
X-Received: by 2002:a05:6820:4b81:b0:703:b7b6:3093 with SMTP id
 006d021491bc7-709413c4d40mr2962513eaf.65.1792681044587; Thu, 22 Oct 2026
 07:57:24 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022144755.65025-1-shawnq1@163.com>
In-Reply-To: <20261022144755.65025-1-shawnq1@163.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 16:57:13 +0200
X-Gmail-Original-Message-ID: <CAL4WiipjAy2M5kok3bkB1Ny=9ryJvrWkt1jz_awuSoPY3Nx_vQ@mail.gmail.com>
X-Gm-Features: AclHuK_ZymQtBac5SLmvPX2cY8IcEsAwKR4_uxsEP0hW1yO_0q-mPrvDW3qvIJ4
Message-ID: <CAL4WiipjAy2M5kok3bkB1Ny=9ryJvrWkt1jz_awuSoPY3Nx_vQ@mail.gmail.com>
Subject: Re: [BUG] net/sched: malformed UFO GSO geometry can soft-lock DRR dequeue
To: shaos <shawnq1@163.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 22 oct. 2026 =C3=A0 16:48, shaos <shawnq1@163.com> a =C3=A9crit :
>
> Hello,
>
> A PACKET_VNET_HDR AF_PACKET send supplies UFO GSO with gso_size=3D1 and h=
dr_len=3D65532 for a 524275-byte frame. qdisc_pkt_len_segs_init() computes =
an accounted length of 4,294,574,091 bytes. With DRR quantum 256, the deque=
ue path needs about 16.8 million deficit refills before it can dequeue the =
skb, keeping the CPU in the qdisc path long enough to trigger the soft-lock=
up watchdog.
>
> HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
> git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
> source version: Linux 7.3.0, local master
> compiler:       gcc 11.4.0, GNU ld 2.38
>
> console output:
> https://gist.githubusercontent.com/shaos26/8a4f7f445aa23601bfe8e04f9c6a52=
02/raw/f4ca89881f7b8163ddea72fbc54b204385142bb8/console-output.txt
> user-namespace positive output:
> https://gist.githubusercontent.com/shaos26/8a4f7f445aa23601bfe8e04f9c6a52=
02/raw/14de8e3a06e7e73c540ebf408e73d301bae3922d/userns-positive.log
> kernel config:
> https://gist.githubusercontent.com/shaos26/8a4f7f445aa23601bfe8e04f9c6a52=
02/raw/6ea0e3da68f1e239d565c64f7906d0f9c73bf784/kernel-config.txt
> reproducer sources:
> https://gist.githubusercontent.com/shaos26/e2add470a38b7aab41f2b79ef021ac=
cf/raw/7153646b9233fa53aca81c9af879d48e8f95dd80/poc.c
> https://gist.githubusercontent.com/shaos26/e2add470a38b7aab41f2b79ef021ac=
cf/raw/e8acddd986023c10a43b5106b4734a456a063deb/drop_priv.c
>
> Build the tested kernel with the attached configuration and boot a dispos=
able QEMU guest. Compile the linked userspace reproducer and privilege-drop=
 helper, then run the AF_PACKET/VNET_HDR test from a fresh user/network nam=
espace.
>
> Impact and prerequisites:
> A process with only namespace-scoped CAP_NET_ADMIN and CAP_NET_RAW can ke=
ep a CPU in the DRR dequeue path long enough to trigger a host soft-lockup.=
 With softlockup_panic=3D1, as used in the test configuration, the watchdog=
 panics the kernel. This is a local denial-of-service issue; no memory corr=
uption or privilege escalation is demonstrated.
>
> Validation: Two fresh positives reproduced the soft lockup, including one=
 run from an unprivileged UID mapped to namespace UID 0. The same-frame non=
-GSO control completed in milliseconds.
>
> Thanks,
>

Related recent work:

commit 8f735d64382dcf162f4276d6699d03ad2f859c0b
Author: Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Tue Aug 25 04:14:03 2026 -0400

    net/sched: bound qdisc_pkt_len to prevent qdisc soft lockup
