Received: from mail-yx2-f4.google.com (mail-yx2-f4.google.com [74.125.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468B24399C4
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991948; cv=pass; b=GLXLiDd6GGYxxmMuKLEeqHG+paLF9t8bezlbYq/owXzJSrSbQmQ8yPg95WnIe3v7hc0QEAHhZuhV820WbLhKc0Vq/tPBpgyIOGd3dCjj0G5wi4N+V+kc5wVMx31cx+rt/i7qsyLDB9margpNZUEZptFuHOWIxK+qKGyjAL0We7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991948; c=relaxed/simple;
	bh=u1c0AJOKpOQYV8POEA0JDva21A7YKfl3x4xor8nmioo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gQQLhJQToakSzWG/4AwMA3gUeQPmpywav+99RtxrIcv0UXeWmSIYur7g4Bep3UlbqeF6kuns6j2ibjFGVDSYrqsA00LDwe3KVw+n2P27i4ViENlQl1amDZ8W3Cni4lo3Ni++YuLSi4Wdg8roqXce7BCIjRzcXs7cjQxDCV0MptA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=zQaUowz/; arc=pass smtp.client-ip=74.125.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="zQaUowz/"
Received: by mail-yx2-f4.google.com with SMTP id 00721157ae682-86785a548ddso4439497b3.1
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 15:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788991946; cv=none;
        d=google.com; s=arc-20260327;
        b=XNKnfyhhW/nunYxjv6uqjQ6uPEroW9upIEOtyJpXbvOPgf5ULsIFfZV+BPxACx482q
         NH3vBnKXF684k3Mwvz2920ftV63NTD3JJ8ww8i0oPXgE3wVojelD7dSvVnvSoSkFkHzG
         pe/0GvHDry04tC9F6jb16HmWzm2ghAVT+Sw39JxxNW7lDvRWOxElEeLZhc8z+CmdhBVz
         BMgQ38BFOoCeMfGvOXb8Ik2v4YiHKptaUNTwZNvfm6veUo0MS08MW2NScuhlEgY7gt+E
         TR6oDv/XbClmc5xDIE/2gX9Ok5vZ8G8KLbVDYvxA6GsIUQ5GcM7zNr9VDbSj0dbh2D07
         k4sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=u1c0AJOKpOQYV8POEA0JDva21A7YKfl3x4xor8nmioo=;
        fh=bd6MnesxUEtnwYJCHBJtJrpWHNjaxkSO33INtaQs9TA=;
        b=IynV1XL+8rUA3n4uBP3eanl1ELjpdw9OL3hEmctLkzw+8VRhD3f/Ov+yARWJz2vbWd
         uB/LrsIO8+QEoVoUbhpc76BTse7B12lNLFXqu/7rNDj25A+wxu/I3n0T99M7O4p6xLak
         KbUCKe/nP1KoPavg/fJjszynCr4PRYeK0PQD/j9riuUDk3bgKKpn8fV689H8sNDOvV+e
         L00eJ2qk3XGiqgca+R2YRrwWzkX9m0LJUgUP6fbNnAh0n5Fbdm28b0KFMin5g8WIttB/
         QD4UweWPMLUtyXCu/Hi56SMnJa8MXusPLjcJ4XomycgrhthlwAh2h9KiAO1aO+Yu9YyT
         D4Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1788991946; x=1789596746; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u1c0AJOKpOQYV8POEA0JDva21A7YKfl3x4xor8nmioo=;
        b=zQaUowz/S/lpIt/XI1Y6oXr/qQ90VItCh6t803aLwXvyXmkBnX7bfwCDLjnxCQjVUV
         tuvTwxdUTxYFRylXEjDYi4zB8ws0r9TzZ7c6sW6e7I410NttMgZx/QQLRtz7fbTRUJ7b
         eoMWMtwz/q4TDPDq06xqu2P5G0nPzHZbviW1hvYbtxYyrUkIP3qZb+JOclUFrolBDucz
         HNBhFYUNwmIRYu5rE6GckYuzyKQXXqx8DTU+iT+2Pv4DvLyOWmF5zYueCWy0hI/I7ac5
         RfAn4y+Km+FDG01d3eNnScrHLTIYAMPIN4OO3xYtKtWmPrPSchSjA65brwFkDQcYDhAc
         /YtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788991946; x=1789596746;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u1c0AJOKpOQYV8POEA0JDva21A7YKfl3x4xor8nmioo=;
        b=EG6y5LoDVyys9LfwsN7luHMizzm6Z/g1WUxLnJ5eWsJ3NsD8ub1QRASJdvw+TP3ycs
         dzn5f5vyRh68qebJ5DGXPYBCXAVTm2gfJbTfeAAvxRIMgc8oYUyc4ZgaB55TAvbFSGSf
         6ffCrM7mSfixshZS8Ju5nMq1RbCIagDKo/1jmjPu7HXsUz6t4eNYSP7XhK61Ec0RnAx8
         9ShdiIseXuWmwSfPUH5UolpR/1AMEmy8WK2PyeqlXwuuUKthPu3wA16WpVew5TKgO8A6
         2EGWDJ7UyrF6V2sneF0p53Pdjrn8C1t+UVtIW6PRMQQHSZz5Y7MAkD5J7CZn6UOZ9ZY5
         XLFw==
X-Gm-Message-State: AFuF++nRJAjxXpGnWlTewTKMw76yq2UTWWXaO9YGntFqEj1bHQXDxNKO
	TCbQeCr039YOeyBJ5G3FGLIy1JxZtWGTGMYPrS7pQBp/k20We2hmMO6P2X4wiNb/9GZJOTRH02U
	wW/6m38DvOMgFReA5FbrZ063gFB+ZceWNYXvr5tUgZvoQvQ7p+/e4UvyBlxveNgWf
X-Gm-Gg: AYBFou2DJ9FI31gFdXESN2xA0T3+zOBHj8r/SN+KaWFL6vPgO1a6qHnqtckxm+lYUar
	/MGhg29ClCs8AdCGptUj80LC3FamT0ARQYR/NtBIa1/AgR2Rg9khm6po4TL/vdUgLVHimiHS/0t
	CwuqL95+j+f7g17D5DDZLp9ZzIrVS//lrdSuw/NYefimIL5eZ99lbK++s8RoWDosS2jOCL3xY+k
	VWIEWy7UlpKi5dpepoAJlGpSUObc2G7tf57Ng36gYyvBudsccyLWCPWWQ9/VaxB6Ek0RjbM23GD
	xIV6ZfNbSwiTzVo/bvrkFkZbzYAxPBZTaDVsJR2zbTe/qZn0MJ7RmpnuWST/+8Im+hga4u9tOcS
	vJBkPq1/FE6KzZPv0B5lkQasB0sDc74kOgGMuwobGdhptemDXgtjGAZ1M1eoUHNDnGnzhvnl6cj
	4E9J2+kP4UCyv0+9AZXBGDViYYkCeg5AjZePhOzq1lJl2o3NOPOVrOOTuBjAYLjxelEtTnoeXhg
	UfpeFhSIEI4zRrIZ2iQd2rj9NQG7wppLX4YsP1cfQV6XZfNrTmeQ7q84II5
X-Received: by 2002:a05:690c:4588:b0:867:142e:f581 with SMTP id
 00721157ae682-87121acdf18mr161168927b3.6.1788991946069; Wed, 09 Sep 2026
 15:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Julius Bairaktaris <julius@bairaktaris.de>
Date: Wed, 9 Sep 2026 22:11:49 +0000
X-Gm-Features: AcwNN1UVM1MUNf3n1Golr8IjSYQEp0Z5n3joRWJnLwyZ--Sl0-paHWdylPTGm9k
Message-ID: <CAC1t37+=keDdX7=G+zyPhBx2LgRNEuoB2tonHF5itrN+Lyx2+g@mail.gmail.com>
Subject: PPE driver: are qdisc or flowtable offloads planned?
To: jie.luo@oss.qualcomm.com
Cc: netdev@vger.kernel.org, robimarko@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Jie,

I am building a PPE flow-offload driver for IPQ8074 in OpenWrt
(https://github.com/openwrt/openwrt/pull/24806/) with a DSA switch driver,
PPE flow tables, port shapers and queue classifiers.

It needs two kernel patches that have no in-tree user, so they are stuck:

"net/sched: sch_tbf: carry the queue limit into the offload" adds q->limit
to the tbf offload params, so a driver knows how deep the queue behind the
shaper may get. Not posted yet.

"net: dsa: offer a flowtable to the switch before the conduit" offers
TC_SETUP_FT to the switch first, so a switch that owns its own flow engine
is offered the flowtable instead of the conduit netdev. Posted and rejected
for not having an in-tree user.

Is a tc/qdisc or flowtable offload planned for the upstream PPE driver, and
on what timescale? If yes it would be wonderful if we could align, so the
two patches could go in with it.

I read the three-part plan (PPE init, phylink, EDMA + netdev) but did not find
an answer to my question.

Julius
