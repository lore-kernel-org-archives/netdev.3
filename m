Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793302854;
	b=v1b9qBpwbiYnMfP1ZMNja5aOGUrAZaiudGeLFJ92laT+K8qxtNj5r6OYpRoEjTT1/kXT
	 fNSQ/P4WkXu9kAGKGWqtlXXqfbowMKYQlkz9Av3chyWHpM37gcWDuHLYD+jCQGHJt5TQG
	 r2OGgr4aL/cu+EDBWxXJPACtzeiLUkcvxw7LwZemLYcUv5Z3dtYAg6sQUT8oAC6eArIzC
	 MFnxOIhs+Dqeq0UVvNLPonGuun8Dim5wO1Sy/g7mDhPyb8hz6rFqC87Wa8aHO/loyMZME
	 /crNIvxQ7BYHRry5eWNQMay/TU9JFHLQK7zY2RsmYmiYlr/WLJ73MXbg9CMcmO+aHvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793302854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=BI99PD+ATh1Y5+RSlEwKFF3tajPLYbWsXiWu2yRi084=;
	b=vcmS6jhsN6gyid/5Qn5COJ/YyjSuwOuhqdyIIhSLC2bvWVF3oGzpjBn9h4yDkDccIUvk
	 A2Z8WTwFtF1u5teD9EMuTh0Ox2t079vF8A8VaEziOC8B7vp+yRKyn/Dn+1AlNCpi3EnSL
	 XstEvVzDDqBx573sT519WPEpMufC6t3sSEaeLsdqvRk0WBpUXTxN+td2ibzWv6waz4brh
	 W2S4hZ2rHEWNGoe2haxf871xWkBNMKxaqHS1hGYpRAIHDEYpRmLFCeiq/oqtWSYi8PYL4
	 u1/mO+5Qut8CDUcw8Qu2Rha57p5R9uMy71+LnbsI1em7GzT9J2wxf+wBFJR/GgjkLRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oy04HEx4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD79606A31E
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 19:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CD79606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oy04HEx4
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-825b40f8a26so25824a34.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 12:40:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793302848; cv=none;
        d=google.com; s=arc-20260327;
        b=IdvtI1P9EhABQ5kC0JmdxF3lN2AIn0pT7wZ+xwgjYpZ2KVTs0z6eY8UPeWCxsP83mH
         9DlaZhF/3eXdFjRB5mjGMpbZYwBJUg/2fCfsH+8tCoLz1g3MWNuXDxUwYLxEYBOPug/p
         IzEMKdRy7An4pmT0bKN2J3Pe2gmSTdshNKKmziNkbMOHGr6pPDNqvRNLDfGSyTP39pAE
         1PSs1WAitPQW1Cgkdyu0VLF43rJFTXuZ45qXi+YRGDrUcu98smDEN8Flc6I5PgfkOYFl
         XNzxMgnoGYAdistXTrSoyv9GAJlxX79A5q6Mb0Pe3+uRHhJWjv7NIg2Jb8sawk7oP00L
         fq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BI99PD+ATh1Y5+RSlEwKFF3tajPLYbWsXiWu2yRi084=;
        fh=4Fua/CE2k579ZG6bD/yId3YIk4v74TUYKfQ3/HDpufQ=;
        b=ehamkg4CupaJJd95Vi9hLX8CA8L7pWjwV79sFcyqatC0Iea6DU+CjHfWp6s6wlyDwA
         i45N/5YA0MHtzrTPhiYxxjehFqvmUGQHDVJH/S+gcW3kcU7uL6PPmiO/j9gFlpio42YL
         XuGUG02q64gHBofFABUs+Vk1bTLySaZMnhJO1jeXmFro1R6BJXk+WR2ONki9979h7O63
         XgxNvnn4avv+rZAO+TNV2dIk87O0OCjj1MNDP/tA/f2BoG2/JYf1zpzffeLePUB43lfJ
         6Eg+tKZQmr86M5I3ZPC6FmgMj7EImhbODxxFky5gwVAxtctT0QtrfyFLbVinK0/2bDgz
         nWqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793302848; x=1793907648; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BI99PD+ATh1Y5+RSlEwKFF3tajPLYbWsXiWu2yRi084=;
        b=Oy04HEx4VXsy7bnK+jxK7wLwJKJgZjMD+ok02/ElUmFMcCdqOEpl4CNxdWoxJzIhzn
         U9RRGRt6Otan88a2NMxx9hAn+vJiyjDSutvbDnQ4fcfybjPlhxmIxNbVjs5s10zwcK92
         qYY1ODXDGpBmd69+yoWLRWbNxPvInfpeDY8XkeJeCFG0nCIscbu6LhWZlJFfvgNakjJP
         ggb9DU+L4K0N5slxw86nSUklX444AEIO8JnQXaH1vGuPc4coVKJTwqNt10udSvszwDnM
         Mh0X5ZLVObaRXY/xgb7VXOmvBk9Hv7hm3jm15v6zxqOE4mkNYW3VpvNXXZHhE1kT1t1/
         7jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793302848; x=1793907648;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BI99PD+ATh1Y5+RSlEwKFF3tajPLYbWsXiWu2yRi084=;
        b=Rql1gstvY6V8kVhzrnY07OuXQH0H1Cy2JMX1E4d6yeGTQZScC4GlG1X2u8GWsCs/VR
         YpCyhp637O2lNzA+Z9wIXhq6bOGz1uQiZoEm0rSoIyUjb+udJaqZd2adJuNdn7dyFSs6
         DqxirTTN4i2/mG7GLo/Pa/EfiImFoKOp7yrj4qCWvmi8pVtu0vAhv7Adzny4qSpmZGn1
         XUiz6HXt90xcYVtltLgQJ8YWqbc9xxsHaftOF6BEXVEU+pA3tVzzcXK3w8bGv4WgRN4p
         mpL7FcPD4bdSN3RMHv0ZTUU9oxYBisqQ3uYskr3L9r1hqkRvKqp4mk2TUuj9NjEHKNvu
         tB+w==
X-Forwarded-Encrypted: i=1; AKwUvBwmK7G1mT/NOgtSytME9wqFGnJjw0ZVMqKRwSz6HHQHnCrh/Sw9R5IATLcy/VTzzC5wMCNLT8M=@vger.kernel.org
X-Gm-Message-State: AFq9FYICfAJg1oqGfXO7lhc6YtGAzzOWv+Gqh/hMMHbCZ2f5X67esuKg
	zkgIy4wGQ4LjhY8qqJLSRnR7KcXFgspCmnrcRi2XlskXqJMiPgaLze2Zltuxj7YZJY8LhH8+ImX
	8iEGyg3zuKTBWDLseu63cHuBi5vHBP/Y=
X-Gm-Gg: AYBFou2OyREluxX3pdwdDMMkagEnYPJ20b/JiDSe9NPTWS/qIno/gbhGaddJ8n8q6/V
	63rYVs2H3ko9LWEWadZGJrCWb51idz1f/ccD1ZNLv4Kqmil39BCqFPvn0giR2U4rMsavd5vGSbe
	ip5uVa9WJNvTBKWxeFJGOJkNHU178+FhttO8byfmG5TT6b4CdV5kHvygo11Bw8+YIieQZRaZAUg
	nByLX58no1PLEPApKmfpOp+qUE9usoadZuhGQD5bOdKDCXApRH44HCUKJlPwClwe9DsDmxmC7gy
	xDPizllB+O5cndpGqoEgPABXG2PQWNFjgiRL7f0wy+FEUv5BFhapBAuU4Z9VoPg8PbcvDu8SJ1q
	dbpCE21fFo8FrdbTKerx/JeHlNvloB2I2FcXCpQ==
X-Received: by 2002:a05:6830:4391:b0:822:95ff:43f3 with SMTP id
 46e09a7af769-85d3664ca3dmr142180a34.24.1793302848352; Thu, 29 Oct 2026
 12:40:48 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022163639.2566945-1-andrey.misyrov@gmail.com>
 <179303675173.3134.11217955296529787762@kernel.org> <CADvbK_dTUCUFn+sLY+zuN5_9+YC-axzM9FVr-yBKJ4jxwebkkg@mail.gmail.com>
In-Reply-To: <CADvbK_dTUCUFn+sLY+zuN5_9+YC-axzM9FVr-yBKJ4jxwebkkg@mail.gmail.com>
From: =?UTF-8?B?0JDQvdC00YDQtdC5INCc0LjRgdGO0YDQvtCy?= <andrey.misyrov@gmail.com>
Date: Thu, 29 Oct 2026 22:40:37 +0300
X-Gm-Features: AclHuK9ZvCDg2n35I76iYH83HI7jntHSzE-MkCUSpArWzEKyyvJVxDkcplmhCjw
Message-ID: <CAC=piAqJCtKEn=jLaoaBCr5yAgF5dibhPYcrZGWPytYN=Ct8cQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix ASCONF address change on single-homed hosts
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, marcelo.leitner@gmail.com, 
	junvyyang@tencent.com, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 27, 2026 at 01:38, Xin Long <lucien.xin@gmail.com> wrote:
> This looks like a legit issue. Either way above works for me.
>
> Thanks.

Thanks, Xin. I've prepared v2 and posted it as a separate thread:

  https://lore.kernel.org/all/20261029193454.1028626-1-andrey.misyrov@gmail.com/

pw-bot: cr
