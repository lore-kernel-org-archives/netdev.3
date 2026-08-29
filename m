Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CDB20459A
	for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788040056; cv=pass; b=LLZQ3TLwEvpnntbhJHDjvaLVUwZ4Bn7m/SOQlvKDBRFl0MCNqObIyzKm6de3QvjgT1Rfeejs5pvc6FKjyo6cajBobCBuxhbqnaW+VM4S3R4vxBJnkey484QYHQzP0QAcCp0S5RdPQteGnlQiqtCH6vnXpMgLHqHMvt63KR6U2P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788040056; c=relaxed/simple;
	bh=dL+VDFU45yCois3gxJcRVnfvOnaaUK1D9SRMNEOKK0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lp3QTVOdkJUJwZxIJn9/lvh7Rzx9aQdR8CDPn5JVjX6ip3H+RAXMSa3vJhHrIOj/86hg9lboXU8U3GuSCMGa8gYer4DH9t77K0/g0CVATMLB5u8KWV5oS+WeD4nVynzlcSrnmUAgE75kujCwF+//SLb10KRVCzf5abi+3jjyKWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6X0Bi7Q; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6X0Bi7Q"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8525efa7274so1789662b3a.2
        for <netdev@vger.kernel.org>; Sat, 29 Aug 2026 14:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788040055; cv=none;
        d=google.com; s=arc-20260327;
        b=h3GfQZeUhKIMmb+Q3oRqV3F9Rq/+t7d/CGyrRmadfXKD6hcfriCuaGf0vlkU38pK4g
         ZVWmPnFd5Y5oCbext/Bh2St5qd2O0cfAvvQc70VgVLG7UXF639/o2Rie4TNI1z4K5iua
         mCc4l50Hjk1QCFA6akbsKHnMV7yox0NOD/euQmeGzJDtgjMj6jCa9dFuLxR9opppxgTr
         KpTwZNAIkzK/Jq43u8Ehyx0hgpP3VHmeIEFuvJUvKZU1Smf/kWtXRKBW64CDquTaHLed
         A1kMEPKTm4c/s7Gq74dJCpZUwLao5artPKDBPCyz1Ww71gMyxbY2Py/bRlKGHRPfoQ9Y
         sGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dL+VDFU45yCois3gxJcRVnfvOnaaUK1D9SRMNEOKK0A=;
        fh=v2dSMgacBgRqHiY3xqwesamGIBNqgB/fiGctN7z1qdk=;
        b=Ot6gboDyG1gLK1wVTdLNNXCwIjiXo6NGVjLiQGozDow7L1CiwdoYvjzHx353OT08sR
         WPiJ/YiX0LZiSF+KACKDT3CA2pa/rSZX1b9C4IFS2h457id14oxlDKli0stK8FfieIJn
         WARmkYFKRdZPdbDRVj7mta3vwlxr0TAtV2b5NI7k+Aj39LbWlWgm4/iF8ckQiNhJrDjs
         re1x1XtWFujnpCDILWoaYjAgjO/Xq9xRVLaQPg/vxcckMs6ipeCyj+AwGhyuG9wchRHl
         mhakEbBXz853DC/Nsh1xS+Ji/XAyRkQtUGaS86XkWIjM/LHhfvOHT5qwtdEtESkwNPan
         y3lA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788040055; x=1788644855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dL+VDFU45yCois3gxJcRVnfvOnaaUK1D9SRMNEOKK0A=;
        b=Y6X0Bi7QXUjqQaAY+GIi1/+XeXVPhstyiKaMSHVCMnW4mbwYtq837X+JApXDrK1IZg
         jhwfzErd9om8vcBeBaVZhitL5kjBgttEP8oFcR+NEh+CQfQ/Nax3q1g3cPXpeCF+g/VG
         tkDvfnwzwnl7X49SaKl+Jg6ttFcxX8vfJX7wp7N7vbtzMqXIwuZ/JHGl7LfEykvHT+zZ
         8OYJvCWzeoj5EckB+OMDwqrdFczUb+KGa2CxH6fWy7ID5ahMcspsmZFA+dNm/QKPLzk0
         dcP33v3GiEJD6A/7oVqCi1MKzNeg3RvEuKTYaDyNkZSuF1O+pdSYfaAEbwk+2tr8kaUU
         kV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788040055; x=1788644855;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dL+VDFU45yCois3gxJcRVnfvOnaaUK1D9SRMNEOKK0A=;
        b=oXrsGeNeXMDyapz+88J5tJTMheszD8C3pNRgoy+M/5bH7+xQPM7nlbV6zi9uAndcAw
         Rvmuj4B+ZimQT4gms8yAVBpafpTZa7wqiEIQSegA2U60UwWjg4H1OBIV9kAHDqE3aWXU
         LTBUVPcF2Dy8d3czmTMH9HQu5hYaOS/79h/Wc69oKj9eBvv2nbCgOHroQN/yV2k5ZnnM
         ZsDrzId1qWBHqa8Q9+a8GKbNw6uPgc3zMpVUUHXNRYVTyfGGWVGbwZ5iHbUPB0Jcb0x/
         P9LCc2/r0zMaGxEc38GXX6oOdn7lK/XGzIyTDhOBP04c7w9+B6bpsmixU4IqOX733isv
         D5wQ==
X-Gm-Message-State: AFuF++lLpzgEsxvMofdjV6r+/GOkmkqQ7kvrTEtN+aBUsbbD2NcGjBVY
	xuPaw9NP161PiRxLKFRXjEGUgG9XAzpyUQhZOW0i73FSpaLHPegdfC/KNOxlYfWCvAfsWuy27j6
	hdYKjfwy478xKgH2JI1j0A4RULOR6EKM=
X-Gm-Gg: AR+sD10HGFaod+TSstKJqmKUNHa++FrJ3v75xuec08MgnC2l/IkSw6kSk24/I6aRfDk
	gI6S6ZjQ0zKrjfIVhsadii2ux50GrmDw6kavlUxD3JkmvnkbA1ovh5+kDzEnEs0BcgLoWRJJgR9
	5UDWImpVN76+puKxOG9Esr76P8o3PMUrw69xcrCYX9YtxFvGlmKzyy14tqQlfLERV8FJDJmgBVU
	f832Ha8mtyi2oQ48jPdLpxGnioYCDKxWYlWcpxJMRT1Em71aRzWl9Ij53my06D70/wm8/oJLIO2
	VR54P0xFOCdwzT1/nTto/41ROIu2FjbHRWAwjJRXkf/tVu9lPPGYsixjogfvCIo5zetIkwKJWs2
	3i+p6D4r53lxt4Zx7cErgHRda+Ru2OPs21iYZt35fXPKN0/9DmFoyz+RZ2oflf6hmnLjC/LvZaA
	qetg==
X-Received: by 2002:a05:6a00:1784:b0:845:3d82:10fc with SMTP id
 d2e1a72fcca58-8562496610fmr24817174b3a.0.1788040054857; Sat, 29 Aug 2026
 14:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828042431.3873725-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20260828042431.3873725-1-bsdhenrymartin@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sat, 29 Aug 2026 17:47:23 -0400
X-Gm-Features: AcwNN1WiOSynrEt77wHMbuhlYYcsQEJr0-lkDpv1WrESJeoHxsfDDV0uqJIQ4mE
Message-ID: <CADvbK_e6K5UZDy=BzjE7OLTQm-h5n0MQD5n6fOOD=F4s3sbqAA@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: fix soft lockup from unpadded ASCONF-ACK
 parameter iteration
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 12:24=E2=80=AFAM Henry Martin <bsdhenrymartin@gmail=
.com> wrote:
>
> sctp_verify_asconf() walks ASCONF-ACK parameters with
> sctp_walk_params(), which advances by SCTP_PAD4(length), while the
> consumer sctp_get_asconf_response() iterates the same parameters
> advancing by the raw length, without padding. A single odd-length
> parameter desynchronises the two walks and makes the consumer
> interpret attacker-controlled bytes at a misaligned offset.
>
> When those bytes yield a length of zero, the while loop over
> asconf_ack_len makes no progress, spinning forever in softirq
> context, and the watchdog reports a soft lockup. All reads stay
> within the received skb, so the lockup is a pure remote denial of
> service. A remote peer can trigger it with a crafted ASCONF-ACK on
> an ADD-IP enabled association with an outstanding ASCONF (RFC 5061
> section 4.1.2 requires the chunk to be authenticated, but the
> predefined empty key id 0 allows the peer to compute the same
> association HMAC from publicly exchanged parameters, so the gate
> does not help).
>
> The SCTP_PARAM_ERR_CAUSE case of sctp_verify_asconf() also performs
> no length check, letting a parameter without a complete error
> header reach the consumer, which reads errhdr.cause past the end of
> the parameter, an out-of-bounds read.
>
> Reject SCTP_PARAM_ERR_CAUSE parameters shorter than
> sizeof(struct sctp_addip_param) + sizeof(struct sctp_errhdr) at the
> verifier, and advance the consumer iterator with the same padding
> rule as the verifier to keep the two walks in lockstep. The verifier
> change guarantees a complete error header in every ERR_CAUSE
> parameter the consumer can see, so the consumer's asconf_ack_len
> check is dropped and it returns err_param->cause directly. The
> consumer padding fix is still required because odd lengths remain
> valid for SCTP_PARAM_ERR_CAUSE per RFC 5061.
>
> The issue was found by ZeroHive, a vulnerability hunting agent at
> Tencent Yunding Lab.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>

Acked-by: Xin Long <lucien.xin@gmail.com>
