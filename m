Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4A53E44E0
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782806162; cv=pass; b=dpnsGcFEuXI66o+aRAhdTEWR7G0KdzVEAs6zVgkw5PU9vEqtPlepLpKQgSQWanu/aJBjn2PvczI0KiAJVsVjqv5ZTvnKJZ8l98IjGI+0cyJiGKvRKOizoFa5E63l12lHyy8bEfYe+D6Be45QgGgN/EAz+0LEiJkR0QYGzVuTxSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782806162; c=relaxed/simple;
	bh=QAerbXdwrDWs3hFNEsGuJmdY7vbNL33qF7H9iN70uy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBF82MIFUJzldx7+J9dRlR7LPwCTg9zItAe9Wictae62aRFGB4cqmasjvec13b72LyIRGsPxpQG3o1RSk6xxHPCf12mfdc63hMknjW5mtf08SoemjFDxmSiv04ru2oQo7QhrkM60ekLMVOWeqBCrouur01VkaxZ3PDBPQ4otIqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iFhXqO8a; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFhXqO8a"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c01c79467so181931cf.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 00:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782806160; cv=none;
        d=google.com; s=arc-20260327;
        b=su97IBUiY0qc4ClDhzx6KisqOcd50GPy4AZSE6KUh4rf7bomEaIO3AcSIqUjgz3tFP
         WSTv+/QK8OAV7CrhowW3NP5vpa6XvnWPb55zcLml7Olk9Enj/QIRyqfdVmDJDe3oAnhJ
         Cq9yHlQgirhqin19Xcysxdwkl81RMKXJGJDSXHxcGZw9Cpw+pPaoW9cZGW/0ZKDyJynx
         0pXT3UDIRVFbq2/aN9DlXLZNlaKjkxa4R2Lq0+8S3LYlB59qAMikSsyUZAWplBieXI8p
         s5B7MFgglIB5oz97qiraswB55dNTM+m1Z5JIhtkcarOgkrtrKq6L19KDls/3/nvEtoOU
         Gh/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QAerbXdwrDWs3hFNEsGuJmdY7vbNL33qF7H9iN70uy8=;
        fh=WkXesB1xmzgXjO7Yp7q6//5rcqTYPWI2iji9T0jvyPk=;
        b=e/LN5DYANvCLEUuIJr9UtlsEwwmLnaDN39vgEHovnm7yeT8R0U48Whvjn4kSU0f0I9
         7uJtzmkC1r/KKjuYFM/UJZfiF7ql6TLczYhrrAzHFGPXrcQ7nDhJqOaahz1Xz5mUHqhZ
         +kHFprZOUlmeZ2IR93QbaOo+nnG9ERUhMV/zmm7QPPJOeMcqrZUxS7HDveVUI6Jm5hBw
         jv5XcY9pO65rdgLkjxwIWlJwR+YbBHP+jritYrxzdUEtLK58gnMn2YWBAyfzEignXu3I
         eVWapW7E5+U4s1jA7aeaKrMZAKYPLQ1J4JdrizCLqnHf8uVNTOTFJbBuYG3aj84vD6t/
         MHoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782806160; x=1783410960; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QAerbXdwrDWs3hFNEsGuJmdY7vbNL33qF7H9iN70uy8=;
        b=iFhXqO8auzNfce3pyrznJE8+IqrE3pN6HPzhpst5ntpc2xFL7W1cNKnRcZtyJbodYE
         0Reb05oba3bHv1Ln6Xlql0+YmkePlwWIQxCD7ImR23A/hoLfhonl5JKT+glt/c0OXdcp
         jZ6IHyYm57WFMLS6RVN38NkOZNO13Dbrk4AZVGSjUW3Qcvxaavwb40Gn0Ar8gqF9SfIh
         2JuoU+3yG0f5NI3tFdq86hBO22yeZy4Vof1jWktd4xja+y04DJ96SmT8lXUCzHaRUTZZ
         k3fLDcTSp239GmoXd4uyV05W9pS5dOQWpzGTp3o0F6aYzQ79kM5/SqrmSe1gBX8WWTqh
         apAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782806160; x=1783410960;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QAerbXdwrDWs3hFNEsGuJmdY7vbNL33qF7H9iN70uy8=;
        b=TMpe8Q7b9KAAJ0S6R9PNWWMFUBK3V5wd1gAO+iwNSJKitI9O40RGamuJU+pSWQWstx
         slIRtk+92WyG6i/h58L5VRXyakXBC1YvGUMxWaq+Hf5kfdxBTS0diEwmbRHonaMFUxRJ
         2gxtB9uZ003Y3s+P8bmy4BWMOlg23QXyv4FxQgbPgY9ffjrenc03smxb/vjo7nM8E82x
         lbkBTZonUYX3L43iIHVK+rnTrgeF+P2c/rwPvd6daeGGJv28FzkoxN3Uzgf768UHRBBb
         svvdNrGDsOVQ7ukys1VYxS4yF1uCGa3MR0+2U4GZ4lqXi+yshvcc32YIWj7F0SN9aeqE
         +HZg==
X-Forwarded-Encrypted: i=1; AFNElJ9MFywMDeqAYLBL4NpIwkrxoNf0eep9IjYXK1FsWrcZ0snh7yOPIt0U1ZJQRVxXqqQ849YV7MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhChOABvkwu3IZcDTkr9bKABwLMZ0urb8mMnw5c6WFv/cBlMor
	GND4+zfTBaamujNf2anbpytKgBZCoTwywWDSl6D34QRYrUmN9pKfZDsPPIeSSCHc+rdDVMB7V4G
	gXDUzZIv5A7kVxwpEkYfjCLeHCwT6999Q62DTkpyJ
X-Gm-Gg: AfdE7cl32jmJ8f+9e8I+DVzAmTXfI0f5YZhaT+rCnaOoI18EyiytpzwgYc05m2fpqZI
	D6de0wiZYqCg2TYQirb90soxcGabSXZCPUi71ls8NcSIlOxDDD2YXYlz8fRujzP2n/BsU7Qy+FX
	GLPJSxKHdKhyjOVdxtAUDSK5whvpVm6NgiXVnBx1ZVNU6NfNJ3e1e3gcQlr0Yq77T+TkeB8MM/h
	k5zIr8eYtEXpnIYBYFHxtyIqYbsHYBadJyunL8oR9tQ8TPyFB0mRZ2L/e36x6EfjQgvYL+pM3k1
	hdgLNlgBCa2xekzUzSPxDOQHXbLbehTgqCH2R40nEv68Z+vwCt/YZawlL3bv1yA=
X-Received: by 2002:a05:622a:30a:b0:51c:523:9540 with SMTP id
 d75a77b69052e-51c13d3e9dcmr5462341cf.18.1782806160058; Tue, 30 Jun 2026
 00:56:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630022325.1556638-1-yuyanghuang@google.com> <PH0PR11MB590210EC36E866B973378054F0F72@PH0PR11MB5902.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB590210EC36E866B973378054F0F72@PH0PR11MB5902.namprd11.prod.outlook.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Tue, 30 Jun 2026 16:55:22 +0900
X-Gm-Features: AVVi8CebDA0SWSw60Mh8rFPDNlM4i-UKbbWuKoH7Xr8ui1YcMavpRx-8bzvSoG4
Message-ID: <CADXeF1EyFJ1RaJqJC8UB=rn5Jd5GLU-2WxrvpW_buRg3O3LMYA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] ipv4: igmp: remove multicast group from hash
 table on device destruction
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Cong Wang <xiyou.wangcong@gmail.com>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> Hi,
>
> why sending this to net-next not to net if that's a bug fix?
>
> In the v1 thread it was said
> >This is a long-standing bug, not a recent regression.
>
> so why do not cc stable kernel to get rid of this bug from
> stable kernels in such case?

Thanks for the advise, will send this patch to stable kernel.
