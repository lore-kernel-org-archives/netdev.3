Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F143EA979
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291387; cv=pass; b=XdedD6n4P7fhnYmS1Wi3OfNiNllgtS6gKvN+VJNM3GeN34IeUp3QP737G5HS0Z2cMOMTdDGT2xPEiwr/ccUnnVjgv0LkAW8BcBLA/+7v+zq8pE/rpc6kwG2VXtWEAG+SEaxhPbgjhy6Y+WvCOhGfVoTM0BRetYgh+aKDGZ3Dy1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291387; c=relaxed/simple;
	bh=AlKlMcEZvQGx2PeF9qCMp6rHE0hq+vPV3sM/CtLmiyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tyz79wVvVJIaAYxgJg/QP3IjLNWIC0QwOtLbGdk26s/Jie7SszCAmH++33u4wagIiZYJbOZbaotx4z0NwLX909rrcJrcI9wxxRFJWyrmzDpMnAuxLsDOF6/aeyrubD6SQSDpwA1TD3LZga6A6zN9luGml8qFQwDf98WEI3fOpAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=sk/6IpXI; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="sk/6IpXI"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3a9787a14ecso21209791fa.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 05:56:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791291384; cv=none;
        d=google.com; s=arc-20260327;
        b=Gi4Sl7ALCowrFE/SEl5VvVVubu+tf+b0l/jKlOVElG9Q81Fs1gF/gObUl+9Ykbme9G
         gy2bc7harbnikCYTs1tvXJWnTVPDg78ECHBv2n5nk4GLPgX/lbTG3Ys0gLA1tjNUCf1A
         whgWnvybabNJ/aZ6lnk4vR6pQ7yEppQHitQDMb1j8zxHxwDDagyo6UYV6itWwmUiYJCW
         RSaZQksuT1b1U1LaT0imIZsjXIfOJDTaUeenAzbe6Q0qnyAcgvL8R0paTJNZSPQY5UBw
         cwqdTtflvN5rNLiU2jPjBu9+D4PNF5yILWYXSH3DJhTMR+l00rSGQ15c6Y0WJ/zp/gGI
         R8vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AlKlMcEZvQGx2PeF9qCMp6rHE0hq+vPV3sM/CtLmiyA=;
        fh=54gP9BWatBn2ga3V35+7k+pE67PYZH8r3aQFqfanzwQ=;
        b=EmqG+uay1zZOw1cOnPvV8XQXZG6/0qzS5cOrQe8y7hDgmZ6WnBxnKhk6+kTVRU0E4+
         xOKnCJjv+fvKq/P5DmHlk1QzTaAijDow9FF6hrPu/VT7uO9vtEq9rXlHCF1V72g5zzsL
         /bxBSvv8neHPDfzEx6IuT1X/CEr36DSpbZKNeYQ92JHpGv1ZScz+BW7vlln2Qh6ofNWf
         d3FQ9NSI0RCAlWf7VGMoEjTRzd6OJZT6ebCqkaeh/Q1+f5ZQh/VF56lE2eqZ3Sey2Tmo
         K6nwAm4sastgINd6jgU/XI2tMHW6grOBVvFnWLqlOZYGaLgb57nAEu+Exb7K8Kxo+0t8
         KKcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791291384; x=1791896184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AlKlMcEZvQGx2PeF9qCMp6rHE0hq+vPV3sM/CtLmiyA=;
        b=sk/6IpXI46QQjuM+G9a6uGwf5gVm41anPvIQP/rB1vMTU1UgEvjRjkR8pTH8YTkEyX
         f42sLvBvLw30IN/vS/eIHJX9ueBmAYW2PjeKJlFVkviQeWh9X66Yk6HvefzXb2Swvgi2
         ho8EMXfKN1LUgxibAk2KZrQ7KH4F8wZHGiuKTnyTJ/H5/Q3GK3bsNTEe3qJ5KfpqO09t
         7O4giEYGdEurFyaFRCQbTvs+aGiA3+Qke7+PmPb+ZSgqvQvFpwq0IN7NjkXfhA8yzpdP
         u4bxQSN5tuj/BbVqpg2LR5hT1c0/tCMrOrTJG1mXO1+iPmDDAdXN2SFm+2EL9IqKtqrN
         +M7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791291384; x=1791896184;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AlKlMcEZvQGx2PeF9qCMp6rHE0hq+vPV3sM/CtLmiyA=;
        b=JOZ68YGtXpcDuPQhebA1EkyL05Q7/OBoplSxy/klxgmdYAcN9n14nlhwKmFQ1RKfmW
         2f1v94KXvKAwSvNCo4IblzhyEAyOY+s2XpqWSz9RW1dtxpb+1baTEHm4yHr71rz4SGVF
         DI/SXajb06/qiQKnOcsKxDUBzW6kSviJGhCk7aOFbizx6TWi8PpwRo3F0Tz3IYcliLFF
         oSo8wadKrEz0+04RsHI9pOm0gsRGSXJG8YfWadUNUQwQasPNygdArIMwzlC6d2Ua+bOC
         gEKhaTadh8LNa9/pCbOwmg/ZF7AtIqRF1p2b1rvUT771NZDg3fomO/5gjzYBF9nx5+3L
         2MfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbfkmvhc2p/t9+xSVnsBnOw5+4of7iEWVo6owwfjQmBs36zUNmQGJFYORag8lraEs/efS6rFk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIyd+I73coubQZz0s/Ol5Hvi7qdHTzNXeUR6RjY8VWeDbf1ez6V
	be7emZHw8tBFicXvCDYHv/rXedi24nHjhsd7PBguuSWb4HFn3aKS9lq0VmlpnnJ8lU4kBs0OEef
	XK5sXuJKk30LeoP2YACPS03Szh7nkJrV2ppQwBE7KDwg=
X-Gm-Gg: AYBFou3IdQvhIHCuWruI57gIzzmu/xJMhWg0Sn5wS23A3L8YX3wUeFkY4foShFhNzGw
	PpIPR2nrj+jux5N2J9PkOdiwmUlSDb//fupWjqigFCcjOWFj/UU6dKsYUuYzpigMNL+zKdqiRci
	ffV+s6Ev+cnXVlXfJb3pJBcNFk73o2+CpLIkjrMAHfp/234vCn3gEz20RkmbcbXQL98apA2l03E
	StwErEH+FjKLozyxpQP8l6LLO9S2kxf21enfJfYtVlqqRACohB5TD2yPRbXJElOQuC7v2hYX9RV
	C+Fhzq7fQxnUbgBlER9FnN7OcnhA9wBjbf7nbWboNfYOepMtbGJSuI21X2d7iJefhoCzFkvGh5D
	Wj597edcd+A==
X-Received: by 2002:a05:651c:b0e:b0:3a7:7560:42d with SMTP id
 38308e7fff4ca-3a99ac22facmr3447461fa.2.1791291384101; Tue, 06 Oct 2026
 05:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790688018.git.zihanx@nebusec.ai> <20261005184156.01eb0ebd@kernel.org>
In-Reply-To: <20261005184156.01eb0ebd@kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Tue, 6 Oct 2026 20:56:12 +0800
X-Gm-Features: AclHuK8CF-8Mj_c8FfiAmTqG16QSFj-a07fr-EYY9YJrSyWrswvA_gV_jKau6qU
Message-ID: <CAANe3eQKOPb8mzWmSVwOLTQpxEdQ09tJzHqXFgHwptLMgCuDaQ@mail.gmail.com>
Subject: Re: [PATCH net v13 0/2] llc: fix listener child socket leaks
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, kees@kernel.org, ernestas.k@iconn-networks.com, 
	leitao@debian.org, tim.bird@sony.com, shuangpeng.kernel@gmail.com, 
	luoxuanqiang@kylinos.cn, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 9:41=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 30 Sep 2026 13:29:40 +0000 Zihan Xi wrote:
> > We found and validated an issue in net/llc/llc_conn.c and net/llc/af_ll=
c.c.
>
> We found it easier to delete this code.
> Please look at the net-next tree, and resend the fixes there
> if the bugs still exist.

Thanks for the guidance.

I checked the current net-next tree. Commit 003f21868b2b ("llc: move
the type 2 sockets out of tree") removes the in-tree PF_LLC socket
implementation and LLC type 2 connection state machine. In particular,
net/llc/llc_conn.c and net/llc/af_llc.c are no longer present, so
there is no corresponding child-socket allocation path for this series
to fix in net-next.

I'll drop this series.

Thanks,
Zihan
