Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C822D8382
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789199708; cv=pass; b=LGoMdTbWWK+Im4/Wq3zCN6+GLcuX8vaLQmQtEAUFd+KWpcXfAzCxGlyrcsxZOgZxOuB+OStPnU9L4o2GjN7VvY+SAngpxtmsTE+iipNJmjFekrnMYey0knKYAYJCqFboIwdxReBsQhlDFmXFL2FLOFJ5a7IwfuK6nou8GnoATCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789199708; c=relaxed/simple;
	bh=qraFBZqrQdal8zEw2/KrvvRvWjYsoA2R+hTRku00T3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfNxY6RbMDNE6fz6UH8aVq916gwYlxpOyZYZOFE1r68t2mayFN+HjXu/s3qJkV+CKj3+yq5WHtxr/eXkeyNvSsSbHfALAQNkt93ia1fMqaZs/6FVLruPyFuvODgQJWuKWFY8WO+2Z/8THA0sxbnNXCrTKg5CRkk9a9+wP9YV1AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQAiVzHw; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQAiVzHw"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff163f65so2523861fa.1
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 00:55:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789199705; cv=none;
        d=google.com; s=arc-20260327;
        b=h5Vk1JsR9Sz2ce6ZL247smnxFBrejF04nzQTusSulV7l1sIy8elxTQM1+EPcGr8ZPI
         WyuGl6IC5BKZskfRxaFnV8U3sYuCaE1IpupSXy+ehHZjjfVWD/ekJ2CTMPudfbSm75sT
         9mI8jCO7b1vEBJHfeitpX1qJnKMZIMsxIBgQYTzp2siqL/9tmRc/zgr746LqZC9kRZdx
         7hLnd9SXOfTnSNpJ0R+dVuF030JdpSy5q5FzR4xGb5GVa3qwJqAx2qm1/s5HddRkS13+
         4Y34XyvSMbc7R9S88GfIYBmMOAbyF/ZeY33MGzVROfezcjCTAAcQvzqxwebPIrHCTRqD
         IcAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qraFBZqrQdal8zEw2/KrvvRvWjYsoA2R+hTRku00T3I=;
        fh=bTgiJ2fUBLlkn6HIaWjnK7WdUwgLJFmcu01w4uaTTI0=;
        b=bif7LgcFZpvir0/MH3nrGR88IG1vSmZ3XVtLj5pzuuQwdGqRs0dkDfpR3d5OSCxzN2
         DHO3O0m8wlIwg5tjWyWGkFYcGSaDxyQyzacB03CMTkqp6QU+hTXcQ/ZL64+FI6mzife6
         m907QHsTqhbok4d5vlDvcH8Qe+k+T2cXgmkksjjY4Kw2VOfNZuFWsU6o52uRf0jOV9nO
         6Xrivji7lPexIA1ZLDtk+L07dIdmXxGa7uSUeciSn1idIoDtSnBUELnnSItr6fzoP0pB
         Le0uwkTZ46Ri3824NokwzVwr+qGJhioRCgwwhTTtQODNDU9DLgD01LGRzf0oTKhcIdBc
         aK8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789199705; x=1789804505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qraFBZqrQdal8zEw2/KrvvRvWjYsoA2R+hTRku00T3I=;
        b=IQAiVzHwoD3Ol+I1nVI7tZ4umYincIqc6wa7YUTmnm25ln3GKUe9hdxYSqm8165f8v
         7gRTIReUghJbbt/oAfwTHjIJnXDoCexr4qEpfkVDHRgpVICLN5SYoqIh9NVgp72nrY0w
         zCqJR0mC91be5aGuz6noC5ihgFZV+lYiX+H6NuJqXzUfOHfTJovqaau0W4Hv3vYxrqbd
         iDuDC2Q9M0nQvhEfI+Ysq/hm0LHJZ43SqaZP/LrDQp1iXdc1ZTCwc/Jjhmhly8mwmJLT
         2x4DjB89ZTp8TmjzjmykXkacsBi6HukjOwmLZJsge9SmhuXXW/pWMudgZ3+DmXEkSbfX
         GxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789199705; x=1789804505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qraFBZqrQdal8zEw2/KrvvRvWjYsoA2R+hTRku00T3I=;
        b=O77Gy7hlwaLfiP9cav3sOl+agyfiNCuiyJsr82UqySRdDupch2UJiiHllQ5cyxGDdA
         Vw2nbkfx8uw/xBhtoWwODsIreLF8bYybNoOYKBF5vNxQ7pr2scBJs1E0TfT24OZ2MOZm
         9IfTGyVSD25hgJI1FWgrym4au/Rp5tpIfDVKJQyYCv2gUcwsJmXH1SO08wNOmBZ0w5pW
         BCbfLGZiS0csWmRg8XEkI1g0vwSrwsBb/3x6bGZhfU8uPMbPceyBPtCZC7/oSAl2mU56
         NLPYLBO8y+ef1pz7EuK76ZM/MeV+bGwDcz1sfnmIA4qW7uRm1fmqmExVlomWA/mitt80
         gEUw==
X-Gm-Message-State: AFuF++m7lp1PG2l/A3RTdFDn4F/jrp0xGvm7CZkRv4lyEytAIhM8N7Cz
	xGsYS7sVasopiLTKR/spocfrrs8if+WsYL24FQCW1mzdhtK3RQ4pkggZ+2vA1N21eQKOJWnx+CJ
	wqDyuEZMJdjj5o5aBYKgNCvi14ymymrU=
X-Gm-Gg: AYBFou0Sh02s45oPYSe6UFu0C/IAGw8KHZz5McERxDOhFBoCQIBllREb5RjGP1BQlxi
	RLJ7QXYOB2td69f9A/cxqiwfJbRn4UjaoyCpIs6/YabyFV/2jrhSg3fqLAXzXm485dw2L00/pbQ
	rvionVjwPDnMlWtzJAe21DaSVi2uKxj+YY0HWITgD3MPPznW2Mv3TB+9r/l5PeHu++XVwNzfLXx
	XIbohdfCgkzgCuBwg0qXz4waQWhPS9xizVRShw4q8JwIPFJERaEAchQF1UPeJZijhZoJXpGBHAk
	RdGVKUs9jkofVX+F/IWK5V9D0DnAl6zx0GOQLcWLMJEstv/dYYec3neeLwM4jQvPV+bQLdrkNvH
	ndvr+e8XypayegPEwlYL4Hvgn6mBcL7pRCGITs3Wqxmkc9VYw9KDGkxMRZuIXfCFurE15Yw==
X-Received: by 2002:a05:651c:2120:b0:3a5:a54d:c8cc with SMTP id
 38308e7fff4ca-3a5b381adbdmr2465281fa.23.1789199704298; Sat, 12 Sep 2026
 00:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aqPxxX9MeGmAqGy6@boxer>
In-Reply-To: <aqPxxX9MeGmAqGy6@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 12 Sep 2026 15:54:25 +0800
X-Gm-Features: AcwNN1VhgUjz0cIUxA0NgGcE4loqFcZjApjBq91ceZl4RtJn8Fq4WivT_OFEx5E
Message-ID: <CAL+tcoAxn5FCHJr8Lp_8n+4pbz2m4gXmfHxhvg6jFOgFHN0J5g@mail.gmail.com>
Subject: Re: [ANN] AF_XDP office hours
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 8:21=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Hi!
>
> We feel that there are efforts on various sides related to AF_XDP
> development so we thought it would be nice to have a mechanism to have
> cross-company syncs or discussions.
>
> Therefore, let us introduce AF_XDP office hours. Plan is to have a meetin=
g
> every Wednesday 9am pacific time. Similar to what BPF did, we're gonna
> have a public spreadsheet where people can put topics for discussions:
>
> https://docs.google.com/spreadsheets/d/16GL6AbdjDyT81cJ3-qUnYvFxqO-RlhtYT=
S68bfQQDbw/
>
> At this point we are planning to meet even though agenda is empty for
> given week, this might change in a future.

Awesome! Even if the schedule is a bit late for me (0:00/1:00 AM).

Yep, there is one thing that needs discussion:
https://lore.kernel.org/all/CAL+tcoCPKPucCJVGD7MA=3DXSUyCte0K7WTOYuCrLfbRTd=
Wv2mrw@mail.gmail.com/
because I see no reply during this time. Adding something complicated
in the hot path to fix an issue makes me feel cautious/unsecure.

Thanks,
Jason

>
>
> Thanks,
> Maciej
>
