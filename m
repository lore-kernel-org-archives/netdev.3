Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45B325B0BD
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 04:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791261553; cv=pass; b=g0A/q2iY78uJNWv1to3lgOLoIpxtMIQVa+ykbdJS9Ny1IIQ9ta7uoy3+QQbc3GP0/q6ErVPr34tjwflbzpye3BEwcdstnxBJW5yhGxYMoQf0n0twNl89G2LSwcOUwrymCiUAT+hUp6sv/NdTRGHI0kvjuslph6rPbi0o1Ad3IdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791261553; c=relaxed/simple;
	bh=0zD50AresuS4NxZBuKlzPnhqOGy0n6PBx0KxjwkOhVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=peEPA0sf/VKLieMUNDizTMusfLFJemV+PDRsOZBaWFyWotGSBgd/y/kvITSt99Ys7wjOp2w0kG1vxH5rC9o0Lef/qR+2wD54k7+GTawUoRlXquG5GI1+/mNhH00l/FKXA/4ot5IbnCoahh6lZSasiJF0R0IQqvlIM9s1sMqinRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5RwE6jx; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5RwE6jx"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9809ce25a29so1065946241.1
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 21:39:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791261550; cv=none;
        d=google.com; s=arc-20260327;
        b=mdeGNg40tlkAo35jV+J8jhfkbR6A65D2WW/Uo8igldgZ7wXX1eo/GuuXWsOGq3Bc6K
         qQ+8BOqAzGoebbY3q2bS2Sp2I2P6WQ7J1vI3zzOOPNIdvnqSC0H8/sDSp2QvdkuTmdEn
         kj8UeVELD8ZC4KXaE38NJEWtbKQ2Z69rv0iw4lnHnaKSU1c+hKwF/otj80bN4weDOsHD
         Z37cwsLa8XmzpY5J45h8nCqLHmZXQbb5iAzdempW18loRJVXhDHRZfnND4QxRlQx9XE8
         yEuK+qaGFxHjaG+yXx+NCE75F4kL/xK5Gic3J37ElzfYITUco/skUwhnfUDYFLucOAUd
         F/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ONq/W5i5EZtiMOmRR6KrqFCqLA2jXIPffovyR6fm2U=;
        fh=A9DBo4vpMSAd+t66H15TY0J4Sr9BT5pEiSZrr5jmbfw=;
        b=YAwKWTzEEYZQr6oBCTKhp1XogXrbULPA9MaAJjtWEkSYQan6bcelvqmzZcdopCvTtT
         cXKYKjji+H0nbNURFHr5LM3IDLUmwS60dm/p+xRJWms959++eVmJPs11hZ4himcRv4FM
         lOWatKH2gK9TKPs60ajxmxY+MpH/9lE+aRA4NW93dm2OYiou1XvS0qSEntl8djxG2l5w
         DuArS0sFIBXNOywVWRbhfnnLDwyY7uaN0RmtLbaFArd04vpgfCWm1fuwQ9afDYTwME+k
         AhhdSlMSiBbAE78n8L7T+XPo3LhY8L2QVNxIs59t54hROh6U3pa58ZP6UH+UrIIhnoqn
         cWvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791261550; x=1791866350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ONq/W5i5EZtiMOmRR6KrqFCqLA2jXIPffovyR6fm2U=;
        b=i5RwE6jxZ8pJVbQ7LtveVV7LOVpzXmXQvvIjIKbTRAvMCPJgzyiHqdOWY+lkSV7p6k
         8uF3GLcoNXwLwUPUlmF51ODRRxtCvBYzrY+5Xssrnc9LjzywXPxZ+6tNNkA4hjc8cOlL
         UUsQJSsLFhWBicLntwCQ7i2k6Nc8ZPcbWOLsPCJT1H2+rCjPW0Vmd1yeLL5v+sGYM/iu
         KaMDaMmwOJnI9dJSJZnc23yb03Ukdju5lSenYzAJKgsDjeK1WHiczTxvzzhsHTdPCwZF
         f/DgnSMHSmJgVMR1QJL/iDQi1WUUrXlJuSY8AQ9fpEwpNdDk0Fh6LmaZiNqb07Oesls4
         KhGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791261550; x=1791866350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ONq/W5i5EZtiMOmRR6KrqFCqLA2jXIPffovyR6fm2U=;
        b=f2OTnDhYkmF1pmWe4jVMDxlOwnl+ryCJJRNY+FxbqoT6Bc43dXL+Jedu9ntIdRMnMM
         RHNhBjK1py435RmhkQvS76clvh1ni6YffvZcPlts0+tV4VpvjdHlhA5a6xLIe3fJiW7f
         L0mKbXI+DZAUA3FVQXz7v2gqzlxTLItkpNIknHhGQxfBnwmzeQeWtJnF0mK1St+VdThy
         rJ7i7v1vH9wM+cEMKuQdb2BgEWDf0pNquvS2umyko3TaColDQO0zOZ3NL3hroaBtTh1R
         NXCI+iEV5xCXNLLrx4oPG7CWCWFCJFZLD851IBai6MWBXc7irGxHRIGkrv/TBbSOb7Jc
         gLJg==
X-Gm-Message-State: AFq9FYIO3lZ0ztQ1xnxuMzlLF4ZIv0hsv4uzM/kv5+C2yj9rmR+GkStb
	YLdeelfEMW6EjZi9u5GJBKfpgq72p764tLEM9T4AApfYMbRmF8NuscCJdHh2eo/8h3yqm0cjiUi
	CyDSmPZFaiQO21l6mxMzY7iAvVYrJZJQ=
X-Gm-Gg: AYBFou3JGv5IkImo/s/tvaAtj0OcTBTTN7MefHOJfs60/R+CW+DhxM5DULCnBJ50su2
	mVGT9w1+v6R9SPYoSpVUreq/KcKnW/mg+MZ2/qmLfQ6rilCD+0580456bBcl3uqBIhMCg7yJaDT
	XKjC7X78RPuXvSo1YF4Ci6nDhu01XN9Or+NnoTPsxulgx02JbkgAHLe+K5jxw6eIDo14ccrxPos
	wion6wNtd/1xqsXbf6Vdjhreq1CuGPjvcX/6MiPVAOEkL3nq7GPX85V5akxIuUuWPtJfyNQFbhb
	dIL+AwZ1LPtR/PkMAN2VSBHxfL2usbCqdD6GcGojwZOTDkGHBJEWsVGMK1774VIFo7klGHlX/J9
	gRZKbhhbqR+7SCKsF8KtYfDQzV1I1xMeqO8rCuM5cDVkYabO/yX8RXUxtScrWaUpGtVNMzdsRer
	BO0ftgraOaNJGhgDcT/kZG3lrgLmPmSeRgMYGQChDZL9rXlWS8q5C4fBE=
X-Received: by 2002:a05:6102:4421:b0:7c3:874d:60bb with SMTP id
 ada2fe7eead31-7c87a003906mr20133137.5.1791261550653; Mon, 05 Oct 2026
 21:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-xsk-suspend-teardown-v1-1-a6cac8c030be@gmail.com> <179083158364.31693.4968269038838216649@kernel.org>
In-Reply-To: <179083158364.31693.4968269038838216649@kernel.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 5 Oct 2026 22:38:59 -0600
X-Gm-Features: AclHuK8x-oUXR4AyeZa7c0_2JwPWEPKzLN2cv4VlS8Xre1iikpXXL7wBlRrMRYI
Message-ID: <CADvTj4oBtxJM5Xj8ThVn_2cW6RCAx+ohc78idqaX1WUP+AM=Fw@mail.gmail.com>
Subject: Re: [PATCH net] xsk: freeze deferred pool teardown without blocking unregister
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Eric Dumazet <edumazet@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 11:13=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrot=
e:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Found by source review of AF_XDP teardown during system sleep while
working on the larger stmmac MTU/resume recovery series. Further
unregister issues were identified during follow-up review.

>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

These are code-inspection findings. I have not reproduced the
suspended-device access or freezer/unregister deadlock in a running
kernel.

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
