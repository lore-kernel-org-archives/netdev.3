Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794362935;
	b=YEjtGsL4MlD2SkoZE0xhbnDQZJsuUxj8vcX2FhyffrYuBP0kRUn586XnK1XMhCoK40xc
	 MSBVp9PaiCSWqpGcmw0AZ4kmR5iD5okRIru3p/xNSGO+2/RW1IbiWbf3iYP87cbfRu69Q
	 EomtW9zhFQhEvWWPEwoXzePQievf4kE7dBOMO3maUin8JHv9iW0frofuHad+jXFuJk7wB
	 +2DXQ/VSFIugkfanJFhmvF4o8nqrcXVdAQrwjlICgWJK6BVjEod14BYBW1gCDXKjDRMoQ
	 lbRv0zZhtl+eKxa6kT+fVflh7AHOI/8VJAATkiJu07X2FoKp9dFwvdmow2hvEZdiBdg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1vai+0yOnLmL4rTWkmRCh6BY2/lc5NbXYtTRY15myc4=;
	b=b9DoQd6uJCR5IJsJICOJCPmT6Yf3EQh5PFRzLbXu9GNUl3rF9yvrwm8XApHE49amGIdz
	 cN22Jg0g097Ka6lx1zc1yBV/hAeGeJD0qAUpM2WQAT3PfN4dBwesErw0w2cMgi4cki4Vh
	 cigtHV1E0jtjJp9JRM5+DKPBnH70W/eIyV/5qAjZm19vlvXqeYX0cVzg7yLCjWV1Zdkve
	 1zbUqZDvgxdgVpKyGb+zWI2gfHwZu78xTsS7bfdedoduW1jAdx8xQWWJE9QjE0H851kQy
	 avba42fHLsRwcfnJPc0kgyXMMnqaRws0CO/3wpFKrIvjyP47cgLoaAEZyLOXgRKHpEg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZEL+K68u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F21F606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 02:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F21F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZEL+K68u
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-372bdb942dbso3476129eec.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 18:08:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794362934; cv=none;
        d=google.com; s=arc-20260327;
        b=a5ZOTmade7JkaqHyQOtk0XFVrbQenZr87z02iACuakmGnmnVl2HL0Sw/zxtXD98g3P
         /rpJSXb/3DKcAHNWgUZgctVcbLtRmfoFiMrpP5hxaGJfujHjT5K3OBqepzXDQGrhuiq5
         6RbIHmiyKpOuUa0EN9IwQp2heivVzjUwvVMJ5QChvXhbUjHqtCIze4qsx58neMAewTvk
         zDFcw2hUq/3bOd2ZfLQx/XYE7MTtVOJIqdfzNkVHkWBJmVc27NIIMTGrVoivgw9ViEDr
         GQsqy9uPqePacIWN9vMcoetAOLu1BWcAISxVD1HCgGw0pzHgbE24qbc+UzHbC/done8g
         yTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1vai+0yOnLmL4rTWkmRCh6BY2/lc5NbXYtTRY15myc4=;
        fh=MxT3h69XEnsJEzqPQNdthVpP6s1NgpAelsPjxZRXQ9M=;
        b=Gbwn+RIf1XV6QJ1Diqx4FgCvi15cFH5ugIPOcfuYWMEK8OlhaT3hTMabqsTYRjI/0R
         CCX4j4/1YQUKmVfgKBwbbwZ/VfVHezHCUon3eej7xkNvAprV24N80Ay1LxzMMIU0IITc
         q7xbw6Fw5FM81z4UtW/B7/FYokCiLgry1G72oc01tGwzjDoabp+6+7612w/V2sAhe0hL
         8txR8ZGbaAKehFTvlnxih4rD60CkgVmUwMpmb2iT6NDpihZpvB8koL9plqb3wF3XPbqc
         aQWLeG12JajY+VFHtuc5vzzJiVbRpMbMiB5q0pQAfELVseuLryf3MCPWp1qglEqjkpM+
         xfDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794362934; x=1794967734; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1vai+0yOnLmL4rTWkmRCh6BY2/lc5NbXYtTRY15myc4=;
        b=ZEL+K68uoOu6F+TsLT8nb8BVSxlZej7sgcHz+vdsVteotybAlWEkGLF9MZdui/Yh+6
         0IUfQt9C0zAelLinaLyVqFz4bBvMTmtIZkN/ZM9Pmlm19gIPN21AdcDv1aF7vHKSjVOs
         iylKgbUSyVOq1zx90EQW9WOhyuR2tuB+UQrSwzZ76MMHmOLqwPhaLyGN03Yn5LtR3b83
         /RcnWVIj/eNlBBkgwv3874HzR6Li6wyj+xITobCBiZEg2SMWoVsRsT750Q9bPTOpbjgz
         P04EMzrW+A7huRoedRHZFB0KZvukmKLRY+qvIkhkJE3FnXtCf+Og4uyDrRwpZUM7ebS3
         OkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794362934; x=1794967734;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1vai+0yOnLmL4rTWkmRCh6BY2/lc5NbXYtTRY15myc4=;
        b=18RERxismWz/m/t8cjydtSV0ZB4JHcRmQ1HjlCkgsx9uR4HSaPoXtDd+Ab9+5+BTKA
         wlCOJHBa1/37tzdRuCThzwQFU4vSsDoF++6q/4PBRLLqR5nzPC5Vdz5BJNRdFKLzOLkK
         cv2buMWO0dHE50CveE+IgnuLCTwUlc7wZXYiqUgqN1PlnTYFzcOxYDzbSGgD3xmQq72O
         mscHoMY+JrD+Yy3WtFgPEwquGTj/jkaqPDC5y9RrILHLsgIa3bNcE6hUBrEt1wR0NQwe
         f0KnhjHir8SvxrfA3mEO7KAcqvTG8LjJ3OeDvgJlEOES4rsMVSkB65BzvgVCFnXCeTAG
         j8+A==
X-Forwarded-Encrypted: i=1; AL+hErGjslB0iBQ0D1I0PBizDEKx42FQlamblEDwoWhJGyIfmAp1A6fAh7/h69+kiHdim79xTVuK4UQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YNn0b72M8Yp/gFhGaUUrdrlyxd57VItN8zCl9Ii8e50VpNosb
	/wzu60MBs1TvgGdybv8+AY1K06y+gCqCubgpJI+aMEbUINUDs88p7fZQmgKG02Pckv2Ro1eNaMw
	aE2slPpMEIcp0ouw+NhkrHEi3ZmykJIG3Q81zY+jj
X-Gm-Gg: AYBFou3MUk882leINyev4TVODBF+QxMT/Jpz12FesslBy86W8QGqa9gJhPZSuvaX/dN
	92go9RBfUliNGwVJkzzjVbdNxGy/FbAQS9QLcwVpCO+YjOPWseXNivADJ/dDlvWkDwoyvnGIkTf
	aqQZFKRuRp1NPSHIlFrRkgCyMaVCAdB7GILRh6DaN68KdbXlG/yQyUS+SDt6cApkQ3LLcJWVJvi
	F+Qp8OD2TMciPTO9JPJ3Uc+/6oC1QoAcT/N+ciPqIJi+gHOe+Uvi1NE4X1wSnposJo2979bZJuT
	7jbZ4n6tC4qP0AzmCjxYFtqec7eTgajxDLGP0zSSkPsFbLtl1kGWALOlWt2NPbz+bNombqNboyV
	aVIbbH8sUvYnQA9L5hmFa84n4UQWVIb/FtSG9UrHZYk/xtM+tK4tGo3bYYleNgH5K8kj4o5V2rS
	OjLcJ1ubOrtoxBKQGgGuUaKxI66+HYJKXZLp1K1lnYbiKs8bNPwQhRgDRQNlIBaEht6v0Nb8Hi8
	Wn2rTg=
X-Received: by 2002:a05:693c:8814:20b0:36f:4615:9747 with SMTP id
 5a478bee46e88-37680a5d9e4mr1580090eec.0.1794362933629; Tue, 10 Nov 2026
 18:08:53 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111020304.1532064-2-kuniyu@google.com> <179436277497.2168702.18011061847143862824@kernel.org>
In-Reply-To: <179436277497.2168702.18011061847143862824@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 10 Nov 2026 18:08:40 -0800
X-Gm-Features: AclHuK8T0E8q6biTyx4iC14wWjNUw5SE7hi-SlwvoXmt0c-paEgL9tE7B85-AVI
Message-ID: <CAAVpQUDt933W3SoKz_bh8T5hWPS02KftvbWrqP19ubYqECf4CA@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Pass req->rsk_listener to inet_csk_reqsk_queue_drop()
 in tcp_check_req().
To: netdev-bot+sinfo@kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 6:06=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

found by LLM scan.


>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
