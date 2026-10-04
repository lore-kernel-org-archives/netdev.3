Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0A3914EB
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791102501; cv=pass; b=bj8Btpu/JAqGkxhmpL6cxxPskGtUZ4WhtgI/1BWPUIL91VZ5HavPmd8Mgnernvn3QwYopzByLyjQ8RON/TpxiFxs7lc4DrWNaBoWA+tSOs0geMcoDSPsQXqUsCiPLPJRakpKwennlaHfujyahIOU8BHcUDrwOJGCTIZjd6gND/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791102501; c=relaxed/simple;
	bh=9lA8RcPd6wW2B50/8rX54EYklSeRBEjjSY9Wj5uA53g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYLCg7aNJtwfa9RO8O3cLmIE5lgN10FZdwt51R6pivQGwUlGFl15aZDwSCupYZuWLaneNuj7FbXnLlZR0XIeWnyyJirb+5TVmfeyIoru7KmDLZr2JWWazD8bZoMI2x6FPDu2PQBXpZXPloC7F9Q8hiQbywLihmOAU09mhPoQ5bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oew2WGxK; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oew2WGxK"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5ba7ed32ccdso830035e87.0
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 01:28:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791102498; cv=none;
        d=google.com; s=arc-20260327;
        b=jQy/igoMAybyZHjYu3a/wDzYaNacZx0sJFDaQvp/AFYlHmySOGLph4XCkWei+KEDk4
         b6tJES13aoWfYDuYLw/8oZPcv+1pfKZm9xCYk7J4AZVzvwDXu2Xu68OMmv11+tQ9c9HF
         6By6KHCf6DWtwkRx0uaTKte7BambQHwajUWB+xGZeqBivhRjxrGnYGu6GZmkuQigXhM9
         j+RhdgJ0IzFnUBEaK5m8a92u48JOUg+Msgi5XNVGy5NPVLoQ47ruQ59qsRshoh6CNHrv
         /2jdTnzlo1pqjX28LO1NWK3KBdDcLNXzg86S9OobIJfPIOa4yEFjbwSITLZTVnwOpVBv
         f2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2UfVrtQtDdLvg2QvC6NkvEB9QpKNZIi46PhakH6CwPs=;
        fh=KeC0enxxvuN/UcKvcYMmy32D8fhn/d4ki6P48tdxlAA=;
        b=F8EAelaGNXjNRJIQnY/Pk0wKQVdm4Sjeag1cdBV4R0ck0y5O34C3bJkPlr28juy1gi
         gdyPOLARJ/w0nY24IIULQgEnO1Y9K1vf4K0cVdhPu07OAnMN/1Jr8JahSNzTFnpqukgE
         3iCQZgiSgJZG2LHQXJ8v7nBs2HfRuh/ZyZb4SG8l/vO1+E/yldL+Ya01EkDDWjxGza3l
         mh6NLbBLy+Q/mOTuFDCA+a+RhHVn3RFPTPOGQRoMAsPDXX0yRnKdpTkqkICxpaSar7tI
         puM8Lz/AjwIDGj2nULXYN4zhHUYg9xIVdah9NqmsqCRp3LzWBZgFe7fu4+JTQeqNmnlf
         LBgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791102498; x=1791707298; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2UfVrtQtDdLvg2QvC6NkvEB9QpKNZIi46PhakH6CwPs=;
        b=Oew2WGxKHUa0d4mfLOdZGpiPWRRcsBF174IuLM1LaXEzqoE4OSKtXOOQFESSBTPaQQ
         sRnZzhtaNgZl55RzCWjRuCU8ZJmzJa4vgnP2cxtgel+uCLtFQOlYBnpchzeK8qX/O59i
         Fl8p+aEeREyLOEFwiuECq5OPZoPzoJG8KkF+IzcgNI5BKrffmt3C2o6io0bN9rUrkBp1
         KqrbQ9TUBmtspdh55ZNyTbo7YnqkpyMJKD3GM4j4FJ2QWUsP4y/TiQJDLCJRb0Yu5Ck0
         Dc+uKlou/neYDt0LQQMiP5FNB5bx+02JMA2PAGqn5swJwAdWg6/6fuIIN+GME6vsp+v7
         07/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791102498; x=1791707298;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2UfVrtQtDdLvg2QvC6NkvEB9QpKNZIi46PhakH6CwPs=;
        b=FkjVcQnhckuyVTCTthm6YZbIcLbzVEZu6fFmlLfYrKM4hvk1J0v0NWjc34t+rmZJQG
         7pLuOlHx+EU9JR2eJOyloNMN8XGGVBg4tJONoxSu6Tf6a7MYx7yktvbtSUHvb8l6TdZo
         I7KlAW2rDw79HsS5AFIfFlRoyRrlDEmztsXRuL/AoOOgacfXfTPIZJBvkIN7gH77o85G
         sKDLlRowLT+4MPm4u3myIVdTYdc+tqGCNmOlrgVYhReRLgqQVrOs9m61oZFWfytCizEL
         o6Jttx3F6QJ3j8T3uHXNWpbgQKI7Ip8Z+uffQr522zsH12fX6btDEr3Imsa6Mi5rQciP
         KjnQ==
X-Gm-Message-State: AFq9FYKonBEBSCqviZG5jVDMw2xh8XFc4o1JISUMT/E7Wa3UxH6DtAd5
	aTxpQ6tuhC+1Gbf7swAB+y46EQmn6lVVwNJ3UoETRZdhaZ7w5G+KvZqBnWAVbyyKQsH7Ic6t48Z
	tnYKsqDmf3AWg8789BbkTEUyEsVErh4k=
X-Gm-Gg: AYBFou370q4fDBjmlW33+YYeYa2sjNszPzPY+1gGBA9gZh/IgaItK2W5qzPB0VJGWgv
	i5d/dJv4Fj72OCHypn+1vkWzca3VIPgzgSggsBR3CJk+ngZoQBjfVtx+APRgMXJd2sWm9mwXQHf
	nb1Q3TqAYRQe+NOlhvcJMQun9JIKUk/XcQQafXSL4xZZKPiGvYDphxWn1v/xVp9n/Kpyd6AiD2+
	kIw5rK3bKGqp97YldXfPEoIBZAfIS3bfonTOD9bQ/Fr6ds3yZgiPOaxZ4P0wtLkjA3FuqT2N4wF
	ZoRcXaJMsxd5Y/aQRn9u1S28lcyZWG0yb+kiWp3b3JNe2IGIjVjiqg==
X-Received: by 2002:a05:6512:3b24:b0:5b8:ed29:c716 with SMTP id
 2adb3069b0e04-5bcb54880f5mr1712748e87.54.1791102498104; Sun, 04 Oct 2026
 01:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004065930.1004953-1-maimon.sagi@gmail.com> <179109746015.1402591.14131579685594488279@kernel.org>
In-Reply-To: <179109746015.1402591.14131579685594488279@kernel.org>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Sun, 4 Oct 2026 11:27:51 +0300
X-Gm-Features: AclHuK94JJK7lpEO1Rvw-VTUrCkV0lBc8k2gs9LxPK6XjrE-JxVbKtZnZ_NtyW4
Message-ID: <CAMuE1bFcB73iDAogQQKrSmj9vUvfcV9x-HahvQDXiMxq_d_4rw@mail.gmail.com>
Subject: Re: [PATCH net v5] net: axienet: do not report TX completions as NAPI work
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	suraj.gupta2@amd.com, radhey.shyam.pandey@amd.com, michal.simek@amd.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	robert.hancock@calian.com, sean.anderson@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2026 at 10:04=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
>

> - What hardware the change was tested on. For driver fixes please
>   mention the device (and if relevant firmware version) used for
>   testing, or say that the change was not tested on real hardware.

v5 has not been tested on real hardware; it is build-tested only.

Earlier versions of this fix were tested on the AXI Ethernet MAC (with
the built-in AXI DMA) of an ADVA TimeCard X2, a PCIe card, which is
where the "exceeding its budget" message quoted in the commit message
was seen.  v5 follows the pattern of commit a58cdf56b6eb in bcmgenet,
as suggested in the review of v4.

Sagi
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
