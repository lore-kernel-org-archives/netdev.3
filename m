Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B768C2C11D9
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296622; cv=pass; b=VbMKoioLfJjOHsu2AE8q5itOs4D+QdnJeazBnI4MSJqXZUeCAmeQqHZkaitzdJ2F4nJyuI7I75szAkj79pnXcM8OqD/L5sWCHcYnVc0fBCyzIxrrUNLNYi9MFs2MGFbhoVwckEyBjCPCGLhRu1XFMMKuffcTA9/+SliXketb/kE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296622; c=relaxed/simple;
	bh=SRMqGUm1r3Dm6PkdgLJsaaU5vrKGbkGjLiZ6byEAo1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkzyHcVRewVIpDWSmWLG9YxVoyrDw7avoFU2xZgT9WcnFgDTu3MsAuGYitbfeojJ3+KTFAnam42mmfN4+D53iAo2aEGKtTsL4BkALUGRS19MZvvAuhEkr6PtlRvvILgbdMIE913Qkf3HdJSmlzr3X77ySk0LSSMCXNC+vAF64gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcOUr7cn; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcOUr7cn"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso6785192e87.2
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 06:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784296619; cv=none;
        d=google.com; s=arc-20260327;
        b=qA4kBxrH8Utt+7Tt9M+islW4g/G2Mk1YDji7iwRQbEJIKYrs5lcmQVELgTlUcqTdq1
         /xjpAB7xKMf28SQGT16v7euVMI1Xe51PWKsPBDeFVKHczk33+Izw8R8k/xzDcvRZ3vlk
         q5ckYHfHwDMLpgGSuO+FSva41RO6sj8+tfmbs+Fa/kCYnh8g3nOsVzvLMhJ7fhNLHp3Q
         VV5LS14DAbr9k60YMDwreAOFmEkwCu06DnW8YYi//r/sJU1u8qMal1JFuxErTK+gnkKd
         EwHtGZGrF5eySWyxxcZpCOigWzw8xgItznAlzCveq6RHs8Vt9V4yKUj3VW/FqWzJ3Qqz
         l1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SRMqGUm1r3Dm6PkdgLJsaaU5vrKGbkGjLiZ6byEAo1w=;
        fh=JI3h9u+zcTfgqfsrvii+M2LwYW6m91hHHyR7PjAVQZI=;
        b=FOw+0GzJ+bwPGWo/5Wx6Nk7pK8nCDQYuDzr4zxKqK79o+aDsewNpvh1wuw0U/4k2fb
         IWAP0/qzuYFdFM+xSAhiIDDEnnHiuUOy8iCxc6X+M9qtnV3xuaAwp3IonSCPQrEqFM6s
         XNgIUPtqh0fwp0Pd4lOTUGL7C8P8g7/5t/Tg1qiNzt3KtIRWBmA+QGEsI3J6dzgKx1+8
         oNGDJaZOSTeWTLZzB0lU1eCwiv6j7MExR19b9KNpatrd2B64xsEgt8Gn8+ApHYh6DJ5S
         PybOjiAnG1vnqz3J5nuyigsSwP8bWCKkayaGOGPTdInudW2upLdWxZLgLwC06bzettGx
         q0sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784296619; x=1784901419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SRMqGUm1r3Dm6PkdgLJsaaU5vrKGbkGjLiZ6byEAo1w=;
        b=QcOUr7cnMAXCFjFOAZNWPE2m3GqXDerOJOllerrwST9uZBFQht1qPCZ7uSC9sa3Y9j
         /rQnDtUj9tUdORh1VBt29PPtUKflTGiWF12d5+likhOZ+tXR0cLgLxdBr9bZzoEo/NnA
         Y9BsE3oOJL6dkzcBYdXJhHjNJntlRoDBYLQJAEejiSqVgZ5b09of5QxIqb6NsIkBPMDn
         umBA4GfcL2LQqBxGei3iLgMerckQaxVPUwbgmVN0UrlC8uXyF581cs39n9xeriQ5xWDL
         u5Ub26J6GMzzE+8vmiPdZxvcIxPZYchCgjBvW0G6e722F+GaBpD6rhjUJmJi3YLXyfpI
         xPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784296619; x=1784901419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SRMqGUm1r3Dm6PkdgLJsaaU5vrKGbkGjLiZ6byEAo1w=;
        b=k+0iskY5bHBF70m93Th1KRtjGJn+CrgqafJ0AtZ6oLw3tUOsh4ZeecC/E0jMQMFKCV
         KnDQtOZCN4k2ctZCNo6NPVg6GiOnYzvCKlPEmHYjuUCOVNToDflGyjl13aRXHKIIeTtQ
         motnUe8gXIUDJPcXtiZ9kSgjSWiDQayXG3hSBAHamUS+f2MIlz3Z7pcrs+uxk4KlB31w
         wy3rj/Nb8yPBE8R/NB8eyQfTXRPj41W62NaF5Saz0oWORVX0pOuUYZj8ZK/sxM+SLzyw
         rbRiIWST2XYt7i55E0XBBO87JKp0zh4aHVjWLT8VmIkvH8mIVF2lYjYiOD6ul/sR7jH0
         xPSQ==
X-Gm-Message-State: AOJu0YzFj2hfRuG6S2zU1HxYVi+2FKuxh5RIRrwKbUcn2OJivfoiLGLv
	hniN5fhF+i2TnL/KxCN6KIoEUzQluHFmVSrPIYRyv/bKY7gGtYf3xnbg+TKG9k2xXajfFqsdgvx
	dEMGaWsVOvXgCr8o9BcLGFHzmou7yYZY=
X-Gm-Gg: AfdE7cnMZhJHhr+m/hUXPdkRuNdWAPXgrO3mSqkZxJWlXbVaTFzNMVwXmKhWhsdWkei
	muYsyruMh/TD1Bg1KzB3N3Q7nYW+o0PEAxEUpYwqYoVoXFR7J2VHnLj+Hko1ffRiefevLkPlvkJ
	3BMF6PACDFjnX+cnWNHxRApbomjYgp95QsN7oyPeMYAvpSCl8JQvedB+tSaK6Z/kb8jyUAkipJ4
	mWTSHCyjs2l1Kxo6cawVyU1UdQ3CwJTVvs8hyzaOKocJw1nftU0y+8ZqKW/un+MohlPoI2ZF1kI
	HnFy1V2eIR3GCTtfeQAdj6pHx0Z7lXkd4w3btFAq86IkP8aQrXVV8DHSG4wjlT9hQm872rdqaxx
	7
X-Received: by 2002:a05:6512:3e10:b0:5ae:c5b2:9cac with SMTP id
 2adb3069b0e04-5b28f9991fdmr723642e87.33.1784296618722; Fri, 17 Jul 2026
 06:56:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com> <20260714140722.111645-7-maciej.fijalkowski@intel.com>
In-Reply-To: <20260714140722.111645-7-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 17 Jul 2026 15:56:20 +0200
X-Gm-Features: AUfX_mzBMeJfWc4hl-RU3D15yr8ZFgtlPUig9TueSwyy2LlqRRDEQzNxFo2tOvg
Message-ID: <CAL+tcoD3YFjedWWWRCxN+3R5w8_yyQCiEd24Qo=L0_TbknQebg@mail.gmail.com>
Subject: Re: [PATCH v3 net 6/6] selftests/xsk: account invalid multi-buffer Tx descriptors
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 4:08=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Invalid descriptors in the middle of a multi-buffer packet still belong
> to the packet being consumed from the Tx ring. The tests should therefore
> count the whole invalid packet as outstanding in verbatim mode, even
> though the packet must not be expected on the Rx side.
>
> Make fragment counting follow the packet boundary instead of stopping at
> the first invalid fragment. Update custom stream generation so invalid
> middle fragments terminate the generated Rx packet while Tx accounting
> still covers all descriptors consumed from the invalid multi-buffer
> packet.
>
> Also add explicit end fragments after invalid middle descriptors. This
> exercises the kernel drain logic and verifies that subsequent valid
> packets are not interpreted as continuations of the invalid packet.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>]

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
