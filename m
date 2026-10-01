Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com [74.125.229.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637D385D9C
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 04:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829244; cv=pass; b=XDnIrPlgvahfeQLLg485fQxl3PL6lbRNiZ5oPGp1IQi4XACskHGyLpznP8TblCr8eBZXV+W1MyxKSIBaPxgNx6D4B4p4Al3KYIl1DAlMd5NiGEVSJd/ZNUu+nTi9ZlPoTjMg9EjoO2wASVfp+zngQaCc3sOa+j/enIu2SDEI/oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829244; c=relaxed/simple;
	bh=SsD7P6PfA1YYsVqoiE5QKifgHw2H/lNYtQ2xlqkrqDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSQQuk/n2nBQcUqL+33C4EQX0KAibUB/mDX0VxTwmfmrWIDRNCTfRDq7rOg93RRlqhwWFNAtL9MUuEr5g3ZUnuqnwbSVqMpHNtRjz0Fosr0SPd5DYkRaeGHcqi6ReGb12d5bYYVz9kwvVrHQ0q+K4UjkgOwN+Ar4kMwJ8iZyjh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSaer8p/; arc=pass smtp.client-ip=74.125.229.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSaer8p/"
Received: by mail-dl2-f40.google.com with SMTP id a92af1059eb24-14e1fe551c3so237760c88.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790829242; cv=none;
        d=google.com; s=arc-20260327;
        b=JGu2LUel1KnprS/43Anv33BMgNGZrByxR9vNYMN/rzCDUOXio7oh/wXKQ22VhbI9E6
         5kStL1bkmWH6lb6mRPijPZGGeiXzj6JVuPukAg74ZQ710aSH4A0qQtWN3VzTgype2doF
         8+3LFTYepkpO62nGTeZ+kX28RFqWPJuPfmZz2URROxkhBz7zDYS1LLfZxwtbU5Hcqir6
         yAvSIH5LQo5j985XRe8qrUVUORiG5gvPSd9zjgIvhpc/hm0q0f8mdm51xBmvlTkVhHQ9
         qCNb89G7N5aeydU7osde6t2QvO9J2Ym/mqiU6/w3ffsKcGg9UXFYC1bPjyJiP9MY3FkV
         5SuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SsD7P6PfA1YYsVqoiE5QKifgHw2H/lNYtQ2xlqkrqDo=;
        fh=sa3KJthywo6uPgs7EmhnLybMHMgnqtd2sSByD0TAmic=;
        b=Tjl4iqrmCdFaiE30L90eyiCK6lr6DfsfcjEwN4BKhQHBtbaR4vfxclx8b/GjPJxKeC
         pqCHHeV0XW5e64tjLCoI6D1MdbQR+2MRziLMKDhf2E/JhxxWBFJbczj8z2Fr3fPFtCau
         7KfqG9/NFRVmgK8W4luC+i+0CUFW3+8PYh4F3PhAThh9AcGNgr3RlB8INN07GNScCFv1
         M/J/PDf7CG5H1oqKFDw+EG8e+68MA8oxeVgU5cQzN5SxGlBCG4Yzn7XZN7oe5mkSQMGP
         vmCCsE4++On/x37cr11+XrxSzscJXFhcr4/GEFcwVhz0Mbvdv+fChyDkPOVBbP4OySPm
         xctw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790829242; x=1791434042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SsD7P6PfA1YYsVqoiE5QKifgHw2H/lNYtQ2xlqkrqDo=;
        b=MSaer8p/sI42pnatnOD0xT1uwap1OtQuj/9Ums7pRw4GZxjEZYLnaAXrW0Abdisu60
         0KY7c19Q6nZChgecO0+1VxLfYLFlZFZn1J/jBV3QJO6mBVllp0FhRSakBri4HZtpNgcq
         JlyUvCviHjZD41Ycy7anEV13Hqg4igje66r0jgIc3m7Tw8MT4sIIiONabiyknRzcY5Xh
         X7zzmfbJjA0UQQsI+PE3xgCT3dU39WvQvDIdzQ+0hDxO1zoH8CoB2aPFlWS/bx+aOyXF
         YODa6bxF42useHea3Edf7WCYvtZZsJ3x9Nwkm5N/NyQIX6orN2ygv/uSfa+RRTet90kt
         YeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790829242; x=1791434042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SsD7P6PfA1YYsVqoiE5QKifgHw2H/lNYtQ2xlqkrqDo=;
        b=KiyTFeSg4TXoxPo9h1FUz2+MMiN1ljAeoE7OXv7S9lrzyPLPppMcNdZdceHNATyvGB
         A07LMz0NSM+bNQZkluQ1ZWYlcDtcYt7aEUYcR74vUm9WW24S6l7LUEqsiv3okIkHZDLm
         WMM1SYGBiJCKQwj/W+m/uvxo4H19qLt20gum41OqNl2VZ/OUsKyKTvUHLQV1qnVcQASS
         VvLPtRmN8bjcjCItgPK+UgU+2svZeDIL/GY2ThQrX3a4OeDsYzlUfesSFZ89vWty444p
         1V3QizJ7ixMPBHx3nsGX4PUOPidyBVnoVvlVd9l+hnIPufcCa3RScFSfij0SuI8bRDw3
         cZ/A==
X-Forwarded-Encrypted: i=1; AKwUvBwhZwWKl1SW/bjTzBsKIl2Jokc7qiGdo5DuMfjCrHLpFB3wnfinH1JobWWOXvXQSfrAP5zcprA=@vger.kernel.org
X-Gm-Message-State: AFuF++mYUnMmD7o85UM0a9Dxyu+gTmMO9J3aP6t+3R/BdyOuYJhlKnhd
	wy2uJr0abCDcAK2vyaJ7YOKotRF8mcI9jTQFD33tAXmWYPj4yq/z2TeeJLCSCsfknEP77hAZNt2
	0BOvy52F+94eEXF+6PLjs85td8WVg8bIgLZSJev5whz9VqLXi91Z2vvYyPFY=
X-Gm-Gg: AYBFou0KRvOChqr9tYlZ7YqebUgMxppCa75KE4h8seFgGU2uDU/nqhAw6JKyQA4JArR
	vnZBdtoAMoL8FjvFvByEpRPO+0kqpXQfLOqEgMI9NpzZvcs+203o7T3eR7uRr9UQloYEBC0Pg2/
	t71M4/AVyWCd8d0v1eRHMx1LZ9uwk6PoOOk59f+5ujUkzJDN51ah3Y5cfNczkA5XEwsR3OLSC6c
	DNt2oHpCmOmaokNdk51ydD/VjH7aHy0Mi6nuJ3qu/EhMF88eb4Lia3WSwrAANERQpAuQBdtrTPf
	4CYtb8mHP3trANx/Z05HcalA+4RAD/NvUh4Oh6MPt3zIaVakiiMV/dpGclGqVsMdmS8k+OgkcgM
	GvJQW+boRUoBreUU1bBsuMEASJ6Nd9mET4is9XWC3Q4SB7AVarYiT49BXves762R6IPs=
X-Received: by 2002:a05:701b:4187:10b0:143:4d12:396d with SMTP id
 a92af1059eb24-14d32fb9a44mr3389493c88.26.1790829241124; Wed, 30 Sep 2026
 21:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com> <20260928-work-unix-passpidfd-v3-6-532018a91b21@amutable.com>
In-Reply-To: <20260928-work-unix-passpidfd-v3-6-532018a91b21@amutable.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 30 Sep 2026 21:33:49 -0700
X-Gm-Features: AclHuK80-WytqOlhQ_cTt40E22rT2LSFx63QxmMEJnVWBKUyH4pl6_lj5c5cTLI
Message-ID: <CAAVpQUAgB+awkOOr6BdVCMVfNJ4tS0WrK-vT1n4pecz44SxC7w@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] af_unix: record the pid of the connecting thread
To: Andrew Halaney <andrew@amutable.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:27=E2=80=AFAM Andrew Halaney <andrew@amutable.com=
> wrote:
>
> From: Christian Brauner <brauner@kernel.org>
>
> Currently only the struct pid of the thread-group leader is recorded.
> The identity of the actual thread that connected to a given socket
> cannot be retrieved.
>
> Add the plumbing to make it possible to retrieve a pidfd for the
> connecting thread. Nothing uses the thread-specific struct pid yet. No
> functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
