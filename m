Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78404D5971
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644425; cv=none; b=IkzjLp4OvdmacYBqjKjKZyQWhQnlWiDqVxJ6YfZpL1zN7QVtcSNg00CWk7kYhKzPmBXw6tyL7V/OkiTUFjjn4Av/vBsUnuvZuXcWlCdedT6SojVtRr0jyIHtnmoiMU9p5qNl8/joRT1dBDjHzOEWAWXhrFo58eXnFcsk7YP/MH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644425; c=relaxed/simple;
	bh=j1yYjfdvtN71lnQb1RuDzx0cffgVcRVRBV6mc2dIWJE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=L+qUvGv+syDcyrFUeZIPGaEHM07mwsv6laL432DLgeNv/2utrYXGjbKouJQ/LpVRDr+cQCMfc+dymD868Z+1LoMawB+7z8ZUUr8y/fATcCmHGPSaInSPU7GAj/6d48tVnAUoZwXBtdXLpq6koRTMIt1L4Ow1OJ92VmuMetz+O5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p4a1R3/a; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4a1R3/a"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-485850cf4deso269459f8f.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 04:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789644422; x=1790249222; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j1yYjfdvtN71lnQb1RuDzx0cffgVcRVRBV6mc2dIWJE=;
        b=p4a1R3/a44085P/wLAXM889aehNxu6Q6YHRFlbV82l3cEMA0Rrcz1bsHcDAGQPhyxl
         ol99zdBsbGdghXYBnsjW1jQrVFhB8UX53Ai0qcfvO2iW8C4vVWE+20Fcx567hMT9DVVJ
         RfSD9oHjJvKlSznmkMKIGllovBfWEbEWQpwW7rp2NwWqpMNpCa4sv6wiaVBFi+z+9tCu
         DaJCJVWljQlAEcE1R3vzB1pLI07qD4pNtMyrC1ZYslHsRiVCuIZ9oWL8WTKsujCO1MRw
         uJcC1btV3ekp1KWbHMMNmhHrKNxIQ41PT9COLXpF1nllk/VAXbIF6qi5pZiUhf2dI9+n
         oZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789644422; x=1790249222;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j1yYjfdvtN71lnQb1RuDzx0cffgVcRVRBV6mc2dIWJE=;
        b=xkuxMKvvY/s8xMvyMT3AN/x+u5RO5byVgDUkKFqdDGxDI/xoN3HOcTJJcOno3KsA28
         xcnKAtpMxRP0jtUpOijJpFVVJLwUMFUJzzTyPF7LUG4Lm495iMKOyfnyRGwK2JC6RFLJ
         C+a5j8FTjabg+uuAv/+sRoILcYaGrGC083ib7sCnXiODc+lPS18PK4Z/2hlnuhxdb7qm
         PsdLsk9CaiZHqGVCxX0/JCruiLy3VAdGiGiifrS8oGF+ULVV8Tcr5l4fOgcABmWb2RFn
         CBrP8ATMrstKuywkFoU+taCoq6lSrEvdF1A1bC/zAqnuPr8ZOuE9KHr89TPgYgD3JGJ6
         jtjw==
X-Forwarded-Encrypted: i=1; AKwUvBz5Xx9nQ8Y4ZesFikTu5bj1jm3XnB1q4WSQ4mbcYQ7ozCVnKFipOcJ47/kzy5v4EJqePomLtvo=@vger.kernel.org
X-Gm-Message-State: AFuF++l81u4E6lASTMI+o8ZwH0JA7FkJBtqWfpiMhsGRfub05mgj16Jr
	U2CH8VyFhn/XpgBH0rSumGZoSYIPy374yzJhWCno1l3CGfPSHImGd6fY
X-Gm-Gg: AYBFou0hsr3AMUOLt/toAkhBIShIsfanU9eaWUXcZoguyYDQAyjSVHueOXCwcT2n+Fq
	xXMB2R2EFVMDQBu7BfmMEooA9Oibt+aztR6QUsVG++y/8VXuOqscskz9VgsTpYfrn4XEsCLkkZR
	Dnot1+5zISh61BYqUmfbmocTf58LmtHSj/GC2p6zjgXceLqXbVynd+mxpIqnrzkIHNAmdb0Kvkl
	/eZYl7WCnpKSG5bM1ze1Nf2gUvz04TU862Dt23zf35FZRA9muoIxevdFnKZUppcIJ3NImEUf0Vt
	kuX4MrEZFoXJ9PfufDn0xUaWTSj3PLkFAJ5kAgZ1mCdZaLI+M3vkou2vZg3SzL9wWgm+EP9HQWa
	CwX5mY5Zc6ZcI8FM9iXBpCDV6GXNcL6s6qgq+kx4qaEL7SPMZTyGOA+XAz3yFruCvX4jESlOsc5
	5FzfgkUgXp+oO8dAPcaq7tTxh3MeQmB6pRlBexAdKvndkLRa0UPbIhF+JL40/ugXjiLnSVSBd/P
	O4/ABrg2ZCABm0TSdQmgHkJ5yPUn68b0INLkT30OBKvvoy4YgcQauePxQ4ywAKZP4DEmqhM/U/3
	vtcJ7g5cVD4zqKrYPfsMePkteiQNXX+ej3YSqw==
X-Received: by 2002:a05:6000:27cd:b0:487:d8f:27a0 with SMTP id ffacd0b85a97d-4870d8f282amr5317777f8f.32.1789644421948;
        Thu, 17 Sep 2026 04:27:01 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1fe7esm15118417f8f.6.2026.09.17.04.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 04:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 13:27:01 +0200
Message-Id: <DLHK013DCY3J.19Y8X3Z0RTWCI@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "bpf"
 <bpf@vger.kernel.org>, "Networking" <netdev@vger.kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, <linux-kernel@vger.kernel.org>,
 <linux-next@vger.kernel.org>
Subject: Re: Missing signoff in the bpf tree
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Mark Brown" <broonie@kernel.org>
X-Mailer: aerc 0.21.0
References: <aqvBPVcN__UX8P85@sirena.org.uk>
 <DLHJEZ0K0FV1.SCQLJJQNS1ES@gmail.com>
 <66d3f5cd-12df-4000-8459-360ba57cea12@sirena.org.uk>
 <DLHJUSTDSQ05.28VUGOV7YPS6V@gmail.com>
 <ec2acd16-40e3-46b7-b120-ce9eec70e942@sirena.org.uk>
In-Reply-To: <ec2acd16-40e3-46b7-b120-ce9eec70e942@sirena.org.uk>

On Thu Sep 17, 2026 at 1:23 PM CEST, Mark Brown wrote:
> On Thu, Sep 17, 2026 at 01:20:11PM +0200, Kumar Kartikeya Dwivedi wrote:
>> On Thu Sep 17, 2026 at 1:09 PM CEST, Mark Brown wrote:
>
>> > Does the contacts list for the BPF trees need to be updated?
>
>> Well, he's the committer, so makes sense to put him in the recipients as=
 well :).
>> Once he gets to this he can probably force push to correct it, I guess.
>
> Do you have a full list of the current committers, I guess there's been
> more bitrot than just this?

It's me and Eduard, apart from Alexei, Daniel, and Andrii.
