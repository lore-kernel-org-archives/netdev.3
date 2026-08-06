Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F5B471CF6
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028503; cv=pass; b=U9rCtw3CE36jIMp+kRLG1zpX0Xd1N/Jz0BpzdDAR73UKXwNzXLKCIrd+dZxHVFSAyIzSNtLgyZYBT6g/IHuJETGaBilDu0xeA2kRC1nKnKgt0Kb6M65mRZay3+RsXjtfim/gcG6FN1mgVZFZRCZeOifizDmE6VsPNZgukxF7VDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028503; c=relaxed/simple;
	bh=oOSqs1sW548/Cuc3dzU3OrV/5YuvuK8xDWGm4itDq7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dusttwi/AVbfIw8p/dvO5YwAuJwaYTq92ssr0nT0sI5kUHk4Vfz9ykqwXtbFQHSTV+1qIKgONznmGbdUfLLJhWlBRoWrAUHeMktbBpqX2tjmGi4LEENyhNZlmjrSnaMYUNbRAH74607bv/KsGCewytn++tvWbadggdYifPHaf8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HOT5JrvW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLpcgRqE; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOT5JrvW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLpcgRqE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786028500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oOSqs1sW548/Cuc3dzU3OrV/5YuvuK8xDWGm4itDq7U=;
	b=HOT5JrvWcJzMURAzjT18Dls9m2FHPQ9nYjRruxHiRKSApZIiMNawQLrjE8d/qrsaLrkfFd
	LBB4ihw7UUCKPpd4c6SreTIkd5VyNbqHRm1RCKzJTLtwwsK0G8xiDr9ItRUPFRFmTP0IOg
	/KxNcwCQr8FXyLfxog01O3RNDQKkN7o=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-NOmKcmFROKWzGCwUTCTXTg-1; Thu, 06 Aug 2026 11:01:37 -0400
X-MC-Unique: NOmKcmFROKWzGCwUTCTXTg-1
X-Mimecast-MFC-AGG-ID: NOmKcmFROKWzGCwUTCTXTg_1786028495
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb5ea36f969so2347646a12.2
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 08:01:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786028495; cv=none;
        d=google.com; s=arc-20260327;
        b=LZxlbyjhyxR7ZvP3t6qojrpHCfeTfed0cz8balI4/XvnS8W450uYuXP4XMxlgK5DZV
         WHg6blS6IeP6XmjJBEfUsJM6zRLdpDmRT9w9JgNaXH0Qt1naIvx/NdiICTb9UOQ4PX3V
         wD1ove6vwJ9CXxF3mVTYJob86SoLDxDD8/s9+LglKdQkfhdEpDh5jmjXGry0U4VgVmzK
         0G8gkzUr60ihr8rWib7FIPSnec/IeMrOieGG4Jskp2vTOp5PD/CXN/3ZjgHdMh8Id1RI
         WT9vgNabVgJukQjCCIX0bkUUtLy1o3+0aHVHkb1OpNeGpsFlv1m/h2PsN2N0MYp4j6AI
         x3ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oOSqs1sW548/Cuc3dzU3OrV/5YuvuK8xDWGm4itDq7U=;
        fh=rr13F9IHM3x/BsA+64nBn2NYubFZgJoFGwJcU0xtGwA=;
        b=DSxaA5cuiRad/EogU9JV3G49xtRu0BwyDVui+k7R7I01od0NaDjVfS/+kJ2MMLOcjk
         m9X6NQUFzzTpnn+HAsmTrRwvoYq+auGzo6TM1VNnDsxgmcwz3ko5NeOJdCDIWS/fQsCl
         Cm1NiZa5jBjq3pRjUCzIMmKjsx8E6O/1ploed4rzAT1y6pj3ZtnIRroDkwmEpVRAR4TT
         DR4h84pgXAwUi3pgDcQZKr7M64tdAB07GctX5a8DHdNh71GrA1nyVTG2WfW/hKDlBRZo
         D7Us5S6Dpubv0Z3i5SSfS+XRvR1wbTDGACfoUtOouEBgJu36EayjBIrghxQY0ShU+1OY
         po+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786028495; x=1786633295; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oOSqs1sW548/Cuc3dzU3OrV/5YuvuK8xDWGm4itDq7U=;
        b=DLpcgRqEturwBgFCU+HzWCub20IiyfMCHmud6ogHm3g+g1XROrZFP+bdKP2mvZpZhA
         f+lVuU7DsUUCN9vne/c9qmBQ+SeGnbkFNhjI2VocXzjRQqrymWsG8yfhiubnQ0ZLfyPf
         qqHm9mOhHGn37PRSwM1zleFmTP5km1+Tb4NJRi330H4BYNY0C1kfZoTIIe35f6aB/lcW
         BrmiBR/6gsy0kMKsaF7vABfYe+byVFPHAOjZqLZBme8ubNAKgPwgOkSWeibvhL7ZFBul
         r626d3FLtrUa58VQin9f6KZO8SmVOxSOPsvLIiBv/kcUxD3Ji2kE8p7DDv1GvVArnfdg
         UqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786028495; x=1786633295;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oOSqs1sW548/Cuc3dzU3OrV/5YuvuK8xDWGm4itDq7U=;
        b=VXa8CV0fk/+W8YAtzkJdZ6JIVVh0lGn1RWdHPE3joPC8WBvAD0oUsPZb/ANTSpUK87
         UtUYJuE7Dlzfw+0BFbpPIDyBH30M7D7dzTBngUJ5+sMnJHUv0Y3lBBw9CsaDOM74ewjM
         PyR7kYoIH6MoFqOpLRTP8aqL5I4bvkG8+c5ErB86MbIkPI7Ex5+3VDo6xh9qhhkIrSIc
         Krhtc3RAmuyHJNsDEuCY0SIfodT/LDOKcKODZoDEUn90ohjpDjt5naeoz7ScazgyXjJR
         anBoSVoGlAfdR8FvyaUWcLciAo4CnlV0zeqV3HTjCg6h6GcESV6JySgFc+ia3noIncSG
         344w==
X-Gm-Message-State: AOJu0YwO3QeEbYng9bOmpTg/MC/etj3uJbGghiKYIeYl7OSxWQxXOTAb
	nC9bWx9zIw7Yk9cJx1G8JAfVEnFksqXlhL+Kg9QjMPD0TPoGvfqVFob5+nCkq+9YdkqVUSR8LjR
	fNBQiNKExXQTgy3mHXWW4qDBHIAeYy26HtzT8ObMA1mswOyC//gPqWQkbkaa+Q7v/QMhatoAbSa
	xxLoab5aOoxKLSqdjTTkB4IMUyC9RR8OBX
X-Gm-Gg: AR+sD13bXbMQ/TbG1EXnX69jj7l3LlD6aT1vQlAGNLgHLuzfqKg87eSL7Dv3LjqLzGS
	/bm+Ug5K3XQKtC49Go0XR6vW+FCYdv89Mt47ggBwPLKHMCPEplSueEmoN1lMzPEGjOpwKdWWNsr
	vAUOB72NnShkwAPiZzii7U6SfSHuGI0S5wX9TAtnFLCYFjEtPUNNigMszqEhx6k8ZrUT77YLgxD
	6O6GSL7EmfsNkGhohm4F0ToQiepu03oyfp7QtAtde9+h8k=
X-Received: by 2002:a05:6a21:4d8e:b0:3c3:875d:705e with SMTP id adf61e73a8af0-3cb85ef8469mr19361325637.19.1786028494739;
        Thu, 06 Aug 2026 08:01:34 -0700 (PDT)
X-Received: by 2002:a05:6a21:4d8e:b0:3c3:875d:705e with SMTP id
 adf61e73a8af0-3cb85ef8469mr19361176637.19.1786028494022; Thu, 06 Aug 2026
 08:01:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731145914.4014912-1-bgrech@redhat.com> <20260804220108.1630366-1-bgrech@redhat.com>
 <20260806133051.GD51943@horms.kernel.org>
In-Reply-To: <20260806133051.GD51943@horms.kernel.org>
From: Brian Grech <bgrech@redhat.com>
Date: Thu, 6 Aug 2026 10:01:17 -0500
X-Gm-Features: AUfX_mwvYsIaD9uGBwjuzJQqIERzpiGCm3Z5i_KTeNOSR0wl2Rs3bglM_fQNHC4
Message-ID: <CAA835F6Too3TDsPPjHBnYEM6ntxV+aJ8J=JPK-MSz_Hf6YERkA@mail.gmail.com>
Subject: Re: [PATCH] selftests/net: fin_ack_lat: fix latency threshold typo
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, 
	edumazet@google.com, pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

Thank you, yes I can fixup the message and resubmit.


On Thu, Aug 6, 2026 at 8:31=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Tue, Aug 04, 2026 at 05:01:08PM -0500, Brian Grech wrote:
> > The FIN-ACK latency threshold was written as 100000 (100ms) instead
> > of the intended 1000000 (1 second). Connections completing between
> > 100ms and 1 second were incorrectly flagged as high-latency outliers
> > and printed as failures on loaded systems.
> >
> > Add the missing zero to restore the intended 1 second threshold.
> >
> > Signed-off-by: Brian Grech <bgrech@redhat.com>
> > ---
> > v2: Added missing maintainer CCs
>
> Hi Brian,
>
> It might be nice to include some information on why 1s is intended.
> But I don't think that is strictly necessary.
>
> Also, if this is a fix to be backported (I am unsure) then
> it should have a Fixes tag and be targeted at the net branch.
>
> The above notwithstanding, this looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>


--=20

-Brian

