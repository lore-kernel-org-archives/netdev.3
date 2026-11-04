Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793757011;
	b=XbCxta3/IKMdWayTFxUhmZSoKOrx2TxaeT153kun0VlPmTFHNLuWNF9lliexs2CxgrOa
	 X3XR7v7Dcp83M5NuwgmSTv/Vi5kUtui7CT3XDGJtmYkv3pGQ2VrFVVfSZymR6FQyg9Lpz
	 4fPtZNvcEkP+37D09pyALxFKXyssRXPqxU8/d4PgkV0e7TlC9v6zLsf8cEdz+FYHGh4Vg
	 4QufDrIPGcc0EkNTs+glZqzeI7ITE2CwHpx1iNySyMmnX3N35+Z/BYV3fJIvySBBwmH0h
	 dImEJapsy5jjoWKz7bLpv2fc4+APId1aHXNwHnUs31vVhe5Zi/6QolVPjlev7txSr8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793757011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VHsUzPQCobyl/WuUdU5dlTjx7QUQd2XVTcnRdzll71c=;
	b=cyq55qsFUuuE68/FJhNYC14dP0moSh3ZW3rM5HN2yroBpvq1fQqtydTK33sj+cYW8K5N
	 zG3ga51ittcJjCsuwUFJwG15I1YYYTtKh+EHfkTm/vQPJT/yIcLuArP+X3n70o2RMzGqp
	 4qiLoVwoiNAFZTi+BYpqPgw5mlhUeLVj4MfRJ4ycH9whQKqh9ADLdVuD2SPuKsJLxxvZT
	 Oq6ytD2cEFC3OH6KtxoTstdNFSIeC4RQs9rXTCC7OolvGRSpi8XfXgaQwSqjjI+5Q5V54
	 QSfV4v6ESRvH+50oBnmvIJjc/UgN6JHAnnY6bdOwx5D9SWgYRGhoCvN+KJxMfXADpAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lIp9F7oq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09094606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 01:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09094606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lIp9F7oq
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a54bba0442so10685e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 17:50:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793757009; cv=none;
        d=google.com; s=arc-20260327;
        b=WUT1Ww0Dcvzj6eHRcL/W9VtuMtL6BWs8+9zB21Az/7vbJuTJPVlbTAAgIUT++rM/2n
         /jyDq89WhqjPm84nByDCHEQDMVmYIYss5xBYnMzFTSP0znOmGgEs9PpgW9wsC+qyO7X8
         i9g9v3PFNY+PO/xMNOkKVX28gft0xgfM0wzl86Dy1V+ZqddHFuHWB6VVweyBN7t9/ezk
         EC+yuJYqqrScO7R741Oeh4VVG1OoGxXwLyDpNmInGha3SP9Y11AHtVUiEchKELwJUbFf
         OvpZzWXrR3iiEDbWMjO0ylOt0Pc/xOHhPOlt6Xx3Vg1dR6OKx9yQ6WI+EmT0dssZyaZ+
         90mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VHsUzPQCobyl/WuUdU5dlTjx7QUQd2XVTcnRdzll71c=;
        fh=1JaMa/XJ9T/famnCEaiff/AhesioPzhGGjkA+w6UNoY=;
        b=cCfeq2+7nB8R7R8Gu4Tbbi7H8AdLLTUbiVg871b9pVHyfz7/MARh0P1rBVzn85TQvF
         e5Uo3gscxS48/XaSGQP3BHIwrAII3YmctnXR34rlSWMkLp17N0oFhNwO2BpEI0sF+s9A
         znl8TWWVgx9JQbuFxLNCENg9wQPcRIXq2IFB6XftfKquoKpsvqm3vNuhQ2aQIrbUQem1
         dRA4E9e+jYacpL5rdu+a/RaJuLWV8DNYCx4ckGpQwx9zHY6mvgKYi9bUI7c71APzxUFX
         +99J7xeFiWJKnh1jWWZeEUajXTpYRkAsZcLKjbGOqnQfb5hPMTgST3Qp/kAh1HbtSSZq
         jL8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793757009; x=1794361809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VHsUzPQCobyl/WuUdU5dlTjx7QUQd2XVTcnRdzll71c=;
        b=lIp9F7oq8uY82j3qeAV1n4nV4VoJCrR/hQLU+NtJUAm6fDNFu7gmH39v1t2bbCtYYx
         FWRY385BBIq22lSXdeCoqFORXFPQ6kESKY95yamqLbntDUTzo2nyr39otao9JyoQBbaY
         LLSWkEZtskDRtlUDsN6/Iq5FEP3nXwun4mU9+jWBCWpMSJlGWvL31arHtALgyJ0K7GBa
         aDyqlSLvF2NZTRb99QC6pDU3THhLe9TNy+G0Dk0Ej5qeTXgXppRXudmIm/88q2SWr0xw
         7NyiX5D64GNNGMEHUXXl0kev/1I3nWOYOoNJP81DsqEfpJfg9oYWA1rE6ZSBnMvat39I
         dYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793757009; x=1794361809;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VHsUzPQCobyl/WuUdU5dlTjx7QUQd2XVTcnRdzll71c=;
        b=uBslw8LyKYqP2f1KWifSwY69r6WXijErq+ELaYWcYWX4IEN6OMm8evwcBudqWQch+D
         Ij4pG0jSV7PAlo6CdMNomrC3x1XwZjBj63dfWu7e1PdV87O6zlHuzxygcCji3ZdbEAdN
         8dPMRdVzvRI0mNgTwnumfXAQ9bsuSn+O79qJD2My5Tb8yzPhbyLJXP8TUnB7SsX4x6MY
         eqayqoCNXESxl8880xNoS2EPVZV0qEQN0RZZ+LKr9J5Hwks2FeePRFHK/Bb0hFKcOX2j
         nu3Sgdq03abpdXabMhOh9mLJEsNii0vgsM2mImkH+Ff5C9D5lNO1hvuPRxzrLyLRc2DW
         8amQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNKv4PQI9TBEQ0cqGHdLOezL596JSJgcqjP22wzMxsvrJgO5DGcl11MBaq/127Q+KWUNR2BpM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZFg5WF25Awvf7s0L4FplP52cwlTN9uPSYyI8yMwisLBAZnyKh
	xezvy0XS3HDC23UDA1c+EPKLCOc4UU2eorDoZZqbtZFTiWBJgluutuTDSUker7KOX+slSptDdxJ
	uYHWaMFOU6zb1gEK+rt65oIRRdqyfRici1h343ZzH
X-Gm-Gg: AYBFou3BDcnqb2Ux6LresNZd3vhci3pVl2CbWj2zvJn6kTjHSuntCa14x/nBAR6isRh
	BZzy1WqTdvrMYTP0eSkISfyNl1uYZtn6OKMoPK3pf+4fHDDCxfTLQyfas3YvasB+LRL726vmZyf
	+f2Ob/XCbhNBk9O3KH5oiIjEcxMhB7izvBqEMFqRX8wmAq6Ai7q1SRpOn7J3jfn9PX6Nm5g3sQ4
	wjbE7JLPI+0uqXqIz4Hn2drTkIiStTR7D4FlQ0IPaqwST+9BxudQPg8KXE/XTjN/Na4gWXVwRjL
	+/VzRrUM7oJmEPM0Z5MQ48DqG41PBVHPDFBAiMkuljwRdxr5++HzYlx1FdtztqSLNwWCZpnnR+T
	UpO9Lzh67ivLrBPR1qEWPSTf+9ZdcZVmjAxq+If8LRQ/EPw7ujiB0jzHYU/e8tDl1RGs=
X-Received: by 2002:a05:600c:a109:b0:4a2:a8c:22ae with SMTP id
 5b1f17b1804b1-4b45fd0ef48mr117255e9.12.1793757009083; Tue, 03 Nov 2026
 17:50:09 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104013606.1527767-1-namangulati@google.com> <179375632025.488859.9511320336418102727@kernel.org>
In-Reply-To: <179375632025.488859.9511320336418102727@kernel.org>
From: Naman Gulati <namangulati@google.com>
Date: Tue, 3 Nov 2026 17:49:57 -0800
X-Gm-Features: AclHuK-5IM9JvG08Mx8jxWfqp4ANOqu6iSUagnQ7OJrd60Zl7MpSQbKp4GTnQvA
Message-ID: <CAMP57yVyKuW_4ZRcuaNSqhaD3dOiYNF8Pkrxr839CT4utiJ9cQ@mail.gmail.com>
Subject: Re: [PATCH iwl-net] idpf: fix Rx payload buffer leak when header
 buffer allocation fails
To: netdev-bot+sinfo@kernel.org
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 5:38=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

We hit this in a local testing setup that increased memory pressure
and caused RX header buffer allocations to fail much more often.
Observed a high amount of idpf payload buffer leaks under high flow
count TCP stream tests with this setup. Validated the fix on idpf.

>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
