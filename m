Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793111751;
	b=FnWk9/aG5T84a1Yw8Grri/WLMXvvhDd+pDV2kN2RL3+3osViSn108ShP903Ug09NvMZY
	 skHV83FBsrGHoy9gMXTmpp42bu7/V68rlSlBGLkzF1yDgdMjX99Ob7csdNgDIdGD98e2R
	 slFZ/IUeVLIi+pHRgRpk80aJLuoVFYFN4oUGBwsWOvweN9w4L5O1jCQd52ymks0+vkJoW
	 qwGYUSTNMmcw9E94d2HmiKm44qeaFTARRxEIqgQYzQ8XYqCssT3o75M3jbCTRj3FUEXZf
	 bvuO6qOHjaZ0BBcN8K5LoSywbOmavwoBh7/0AxJP/uPXhhoefHONteMj66ymshOtOpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=8ntivL3sfq13MqlxFs7OFXeUXQKCco09Bn0M/NaUypI=;
	b=A5u/f+puuylNnV/A6/gUXTR6PL+pPtLHnCGHa4IiNou6z04xlFyaq3Zj1k3Ov/DB3qFX
	 0iM167sIS60mmNBScbfmL81hqMadl20JaGlLrwb587rYNEsg99mGIFo0aMmm1TKUjbS50
	 A79XVKvEK1SkrqluLM1TMJgotTzl/yj3ZeR8O9ROV0lRN6/MAkH4XvAOL3h0q842p6JZT
	 BCHvmZ/zxS8Ry+gce+ePMvooy87kKEitiStx+IuzIRXCxnKq9kyIYc2uK/XUuWv8s/J6V
	 3OTNwrOPPwWfZ+MltSYwIW+VnOPIOs5IvDN8sMm0+wJfVnOXaYw0I6LJkM7TR/Vleyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="BPHrw/GM";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EDD606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 14:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93EDD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BPHrw/GM
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4a75171af39so1144620fac.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 07:35:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793111750; cv=none;
        d=google.com; s=arc-20260327;
        b=bua4Fmi2csH05Jye7nFBj+PpWW869SzeBIVlMUI6nG8mjk3+wBgIwb5nnEE8+1JUgB
         aXF/ky4eri7i8DXBvirDchP7G8ZoKz8SQ2LIXMk3br7+Eyfac6rtL2ehOQuM/+mlLD0v
         axoP0ycYyOxeLbX/QEYcMI2c6eiKc6PwgquEsiTYc3w8s8lICQjeu6IdulNlH7Kjcezf
         FuUoy2kuc8m7xtRIuJKwRXx31WLjwKn9aihXYM/f1HqwZKuZPXoKLnbA4Rt0CJcgFZi2
         v9laGsSM1teUp51QHLsmlv8ASUcGaFrkQct50u82xXzk4i4bGOuPlwlIH/+Qlsbn54YB
         0Kww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8ntivL3sfq13MqlxFs7OFXeUXQKCco09Bn0M/NaUypI=;
        fh=DbEKU51LDX5XNgkGRZBsS0S/LVyyyGlUPDdxT7Ubhng=;
        b=KkYsxrSdWbXhBMN1u3erYemU5lFDtTMp3lLQSlXMAqkFTYvAlQsoDrB0xfxwMZ6H4S
         Z3pev+6h9zOKrxz6xJ+gaj3UXPCRn9WVapZb7HwXLnX6Yp8nzu1t4RkpRy9YMyy/MjyL
         iPoixMI4CbmZUYsNz+n/kdO6cfCOBtumuPUOELdjlWUXhQhJgrwoP2VZSXm/yFxGCgXj
         xC9+NlAldYY9GeoyYJHhT7vrPLMKPCrLgnR6UO9J7FuwFw/ycDMIAt065rHPmL6horEQ
         FnYTDLxDGOA+InTlVsUN2pWF/8PgxVbMweiolSy8njFn3/R+mrkczbdSvkTtOs8gK7kq
         rU0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793111750; x=1793716550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8ntivL3sfq13MqlxFs7OFXeUXQKCco09Bn0M/NaUypI=;
        b=BPHrw/GM11uvEr89aRC5HWLHrjkqGaOlu72HZu20IRNW12CbqeqCrUCf9XjVaO8BdD
         Tm8BiiEkYjWF0IWDeKpX2/TO106vYj0TEZYlvPNycwaNkFJ4w7/aWhfXp9YRH+HERKRx
         D73zV2v0PFjqkX+1jrsqekj6gkctsf1ZHTYzfhrQXEsRMxP5J1+IkurjxaHjIz+3PUwS
         W2fF3Itr3kRg4YOPfQ5ZamB5CrmSIzJZEEd7XCc/Qx2awoLw67BeMJMwsILLq2Pjmaej
         tYXdVRezlI4XL4vNDCmp31+c0oScTJVaeljRSMVdvMVe0N6YtdKl7ws9yj7/XN6uFh9C
         JcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793111750; x=1793716550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ntivL3sfq13MqlxFs7OFXeUXQKCco09Bn0M/NaUypI=;
        b=Namzgh7A0B3DL1Hjd5Eg48IC9Ty/asg0oTBs+TQqpuyw0H+UrPnN/yyE2aKqkZoYFd
         ptJ9f8ji7MsczR5h8mtF5oD3x+fwzXDu7qvBHDwTKeAnMexp0sumaJpOSjCv4+p+VH/3
         y1JK7Txvt9TiR3wx5smuCM61/a7nshaiZksOw690KFWJ352HdIQwPhT7OjIhiU42rcq5
         VtK5N5UnqWW7Fn8c2GJO0/YXGrJL9jniuOQAI5bAHq6VcTB82l/ZA3kRmrYEKLC8sNgH
         vei5g9et4fo/VGb7UggzqTpIpBcGdDPDxIDYKHe8GAbLEoyNdlWfSDvlgBEGY7ND4P8U
         5MHw==
X-Gm-Message-State: AFq9FYLU/Gr3lCreh06e5V2gKz63v5o+Z57GCrN6Ktk/r9G3BxIG4Emq
	EOkfLhiL1nNvKjSLxcdgIPBqW4shYJ+t9Fyh57TQ5iPs8sLgkT92C6o8eNr9K8awL4m+OLR4OM4
	gOGQbItS6jtVsbDD7Jui3/CFshHLDYF0=
X-Gm-Gg: AYBFou2hH9PARLNqqavzZFO9lI3OOfFgjdjSPC21xVufKGSvVptJMt0KIYRXSA1Imbg
	2zYttwPTygsiIpuxd2GncwD5qARYYLpktKzRdNygIWJO82tMZUfyVlfBGKzCt24YOfq66fDLm09
	/GjpLrTVyovlXZHbVg5CuiBOSTJr75MvjbVNdaUKRqeArK9kVMDgLFCKeHtGJ6AKcmfSjCEy8qS
	od8+a5WP61POH14l/O7CCERuJ9Cj9Bor8ZJ1KBshtYIivwto9z6NvYnaSv0i8xYp7oGs9P+QHOW
	PHrnktIZOSJjtHpk5rdRJvud8qKO74inhUSXIrUMwfTq44Rxf0xuVUfviMJ9EaQGMIorE1WCkI3
	h7Ug/DVhN5zdqF/ZN+1zr0WghXzJddoToMAOO7PWprjyjYlzrago+yq24JGOjiCGZyfQf
X-Received: by 2002:a05:6808:3023:b0:4f4:e1d3:b295 with SMTP id
 5614622812f47-55c0035e550mr5910025b6e.63.1793111750418; Tue, 27 Oct 2026
 07:35:50 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026083252.12684-1-mmyangfl@gmail.com> <179300378438.3327.666635400432470005@kernel.org>
 <cde7570c-50bb-4813-a461-04154d4cfa65@redhat.com>
In-Reply-To: <cde7570c-50bb-4813-a461-04154d4cfa65@redhat.com>
From: David Yang <mmyangfl@gmail.com>
Date: Tue, 27 Oct 2026 22:35:14 +0800
X-Gm-Features: AclHuK-AndTJtYxew75qcWywswF0KFWtkUg6fXVQy29AG-fqIS6AS7eX9kjSkck
Message-ID: <CAAXyoMPTMtSbbq4FeTJPDD-gfcawEOE6HAucEhG7R+MXdjUDGg@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: motorcomm: Fix function parameter types
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
	netdev-bot+sinfo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 8:18=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 10/26/26 09:36, netdev-bot+sinfo@kernel.org wrote:
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> >
> >   - How the issue was discovered, e.g. hit in production, hit during
> >     development, syzbot report, manual code inspection, LLM or static
> >     analysis tool scan.
> >
> >   - Whether the issue was actually triggered, or is only theoretical
> >     (e.g. found by code inspection). If it was triggered please include
> >     the symptoms, like the stack trace or error messages.
> >
> > Please do not repost the series just to address the above. Instead,
> > reply to this email with the missing information, so that reviewers
> > can take it into account. If the series needs another revision for
> > other reasons, please include the information in the commit messages
> > then.
> You should reply to the above questions here.
>

Reported by sashiko
