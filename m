Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC6A41C6A
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788834765; cv=pass; b=deZlPXxNCVFvZo3bUQR9lFj/QD3eTcf7mOh5M+lSdil8PNKGssu0K80r4Axhei1uLntVVphkCYAQt8HrtMOazvRjUPqsIUyJ3Rjou+x7OxstW7ce/3HgtoKVJCo6+v0Vbl3gWe+HR/TdGyyVSfiPUT3jVWzFIwI51ivWV1HdKZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788834765; c=relaxed/simple;
	bh=TtKy5xkal0yQAs+sExFPNxFJ+y8jjNO3NoOREs1T6VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIGGJfA/84uUyqnlKGq6YOaN1PGoW8Sb/f2UPSt2xdQMQGekAq9TcVb4vZfhrjEBOovAVjNYFFxEAI71S3miwKVMsn79tvr27OWlDkv7CocT9C2HElYhJMIJrFUfHR5739nxObjEehPAlU4A3BuRuPJEN2Ej3zuOiFVgQCMq/ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRo5xlXW; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRo5xlXW"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-85339ed040aso3194401b3a.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 19:32:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788834764; cv=none;
        d=google.com; s=arc-20260327;
        b=U69joE+FY7LiAOeKVnL4ngz0NUOpsY3d/z+VEsV/UO19wdQT7eXpuahkRdofbpnP0k
         GIL9An3FtJO9CS8iN7+lUdqg+4FHR0OMotGz3LOD/eurmPNvGvQjo0AuiFJwaMAggsEj
         FDdriOsQZkxpEUn/oPpUaTdeHLWZGORW2KdPrYUZ0UkeOaWdBcB/9cE93LSpb81TppIN
         FGzVlfJg0GXBea0oWeXG/Dj91U6IEYuhB0HvKsbp7t945ok0FimzfaeRTzJOsrfqf+bA
         hIZJdfVB7gvX84BTtTh5F4H8/MCasR0/gO8pSKFHbCjQEAy2hdSp94W4GGkT1hLjX5x6
         WfWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HGD5b6Vz9R90sdvVguq5WIje3KUQbM5Qm1jcj6Nw7+U=;
        fh=n7B3xFcVkuyq+ATUwZBkJa4hj7IQW0gAG8YNSkY+fVI=;
        b=s4bfI6wqIccgcPkokX6BQZYzrfj0C7VtF34bQCQIfB117ylRrmL24WZc4iKiU2Dlvv
         SSEfiXl1tuD2h4+6xwS43a2N5H5huXQX1mMJCmZA6MXk6yHiwimncgdb3ViLIzihUWmM
         5hQUSxL9wGK+VXHUbhWvD0TTHV6GdM7iNZF3BXfSfix7Doc9ynLNV05v+B0N7231/Lg7
         blqQ5ejxqOqxid7JmhTR9K9QG2Lj+EqBzjMWhCxsGf0WX9JhQFYLaF9csZzGmT0AOosD
         dMn/l0u7eVqtxXNMAtD1AT1WwwU2fAq3eM43n9wbHiAJcN5jOX5oOB5IBcFEQ1sLop39
         04lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788834764; x=1789439564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HGD5b6Vz9R90sdvVguq5WIje3KUQbM5Qm1jcj6Nw7+U=;
        b=kRo5xlXWrRTgAvxfK/qlZvMWKzZeyWGqTS0nUE9QvpgIOqetvY2DpPp932kW4RSNsb
         VmNaGNMQA/ujX8fYVBpWtkxnHpcFLfgSW1hspT8Pjg9iCuu+MyB2h4pOLrX7KwZGR99R
         1F4I6zbV6xnQ6xV2bmtpx+LYTZ3WwTwR9xjE3F5sgCZpXK6Am9xwymWndP65jLIExzpt
         AJXxspMthBUZZWKDG/67rXacTDzLS3qkRzwCpUb72My8GUO9xl64Jd8BLG1k8RmVzswT
         EgpMI/NPHXWPZO2FDrrd+glR5vpzmD9ZpnHQD87k4dAjxYccbute2LZW3KUYpAf4ugUp
         Dk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788834764; x=1789439564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HGD5b6Vz9R90sdvVguq5WIje3KUQbM5Qm1jcj6Nw7+U=;
        b=nt3qpJgckrXdfJOKZ6McPJfBb8PF2bLcuqmCEpADL5G1r3Zv/MjVx0pv15P3F7UggL
         EAbZkKk5/wciyy/0Cf9quk4oLVu5VrDoP8PEN8g1nm5A4luIrTJSU3ivQXdwrvFzQWon
         V9RnZI6zU86KSHI/wq9og9GsWNHuUwjrtN8NEdmYcePp5PCzf938d1MqBQ5K1aBun0PH
         ZviMcGW/wLW7BINEAaSX0XwxlyoYHjAEDMmDmIpFN/ASfp0Q8lem64Y15k6WIa4+1Mwr
         pcUgb3+PZ+a2POfUd1K7BJS60y4cpXp9qbepyv0UbMdGHe+AGIbBhx+mDA5QBI9/+zzr
         sSew==
X-Forwarded-Encrypted: i=1; AKwUvByCKOMrnOS6vFNIOIacUscxvpLUXF2Ntyu4LrMdKe2stWJVugA3P0U0EykLX61DXa4HF9EyrwY=@vger.kernel.org
X-Gm-Message-State: AFuF++k+UccPMrqLkFoQ7hzMx5abag0aG6QZOKsTO7sBnzjC9/v7G2HM
	CHVb6RtLO91BVeoBMaDtjrFfAiZ5rtP+aI+tXYdMvQ6534xcHDrXZtaCcu4wWwozPbxAC37RR3c
	UWDInD9OZEq1OG9N4v4l110qUDRGz+kw=
X-Gm-Gg: AYBFou3yYjrlnlMI9LeIqTwYCNqKmVBojKZuouHCOkQtK/yRASWstzFplhKr45qwxCg
	4Qj2hIrJgq4ynh34wjcXaTIKvWiO7e3E4cGg8wB1slK4EYTDMxV5WWvXkMrx1gwOnfc7zjPVU2/
	3K1wZppyhgrfxuM6CWEy+fS8hEIz/nalF+rcj5nvMz7Xa4ujjES4ud/MjWTuI9/MMiDV6ChDL1E
	NMDd37bvnLRU3lXd4HlS45UIDy7OIowHJ6Drl3eiDOItZz4pzqjSyNiLEVyb1iui1azDqjs2QtO
	JAvaIbD3LQ4zpL3DGCXT5HeTnarIPUGa6gJdtG45enT3LqeUxUeT8oFR+FQ0GFGA3L+dqnLd6J6
	MY4TD//KGPMHk+ooBN/4w1VUxxEj5epLDHpOHWlDruH3fNKic03GZyEBU
X-Received: by 2002:a05:6a00:10c9:b0:845:363e:12d9 with SMTP id
 d2e1a72fcca58-861660e3dacmr35566950b3a.3.1788834763748; Mon, 07 Sep 2026
 19:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903073252.339250-3-phucduc.bui@gmail.com> <178880965410.219967.16945994924537630103@kernel.org>
In-Reply-To: <178880965410.219967.16945994924537630103@kernel.org>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Tue, 8 Sep 2026 09:32:32 +0700
X-Gm-Features: AcwNN1Uc7OOBBtUyoJPMDv9iTOKu63-H3SRX_PRIcuXsc9hMlCIYJizmbeV2DYI
Message-ID: <CAABR9nHd-S-3MgTAZk=JMCDEkHjuHqwsE_9h+14tXdhvWdn_SQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/3] net: xilinx: axienet: Handle optional IRQ
 return value correctly
To: netdev-bot+sashiko@kernel.org
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com, 
	horms@kernel.org, andre.przywara@arm.com, hancock@sedsystems.ca, 
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (1) =C2=B7 Low: 0
>
> - [Medium] net: xilinx: axienet: Handle optional IRQ return value
>   correctly =E2=80=94 the patch carries a `Fixes: 522856cefaf0` tag and a=
=E2=80=A6
>

OK, agreed, I'll drop the Fixes tag in this case, since this is a
no-op cleanup rather than an actual behavior fix.


> Pre-existing issues:
> - [Medium] DT binding vs driver interrupt indexing mismatch (pre-
>   existing, not touched by this patch).
>

This is a pre-existing issue, unrelated to this patch. I'll keep this
patch's scope as is.
