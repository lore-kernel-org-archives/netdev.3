Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F128392836
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791496092; cv=pass; b=cNQ7pgO6sPmeFJ/yIVRPWkoTYxfVACn9wImtKR9KNue40HKJYSzu8u6oMDGrQ2j41y1M8j/wmvK7W4NHpqB47mJ9HVGICXN44pgFBwfZ7H3q994kBvIXq6rxchOvH8vnez404GC2wONiswc2GJaCkImwRDOIjdqxon3LsS3iTMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791496092; c=relaxed/simple;
	bh=d/cxQi5bl2KO3QA7Ge7jeOTx9NRmHL08KKAX7/aHZBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3L8YnbEqvfPha7S0cyVW/9om0Xj6kd5l9b5r6AOwVNWfE7qY6qTngpMuJewE1+3/uSE3PTMTO1WvOoa+w5p5nD0jP9AB37NB09Br1YcSjRCNmaBOINIPX9N6yZHQ74j15pQmnopvbVHsmi9roy40Ngis2ToA8sSPH8VFxvpHiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i4XOrfKH; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i4XOrfKH"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5337fa12431so60591cf.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 14:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791496090; cv=none;
        d=google.com; s=arc-20260327;
        b=k4xjVQ0A1CEPPjcRr0BKY+OUl8B3EbwzZJZ17n/8+ELK97L6gKiaMKNypdI/j5Vbeu
         4IJCbqA81ePDC1lE7jYwvHr0IwSyD7QlghUIT3n/ihoqZdmT+2H50/HIVFnU3RiZUhjX
         5MEEwBNfWHFMVthVnNMN4DQQukoZfNBJABg35hp+pm2GL57WIpJtcrsM/mGdu7kR1ACt
         9lMgosZyIH41ijCY/oKa/SitJLiMF/deGiXDmbzzw85rZ1J7jI/HKqzOs0wBfDfazQW+
         iisWZjENHhKteUiTFY4UAStDodjzQkAtTdUVRnffUsRuu9rqGesSSrP8M0lRnhBMeIU0
         w2Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d/cxQi5bl2KO3QA7Ge7jeOTx9NRmHL08KKAX7/aHZBM=;
        fh=I8Xp3XkiK44TjJzmSELyb8/U1BYoXlwYEmDO/OCkMyg=;
        b=jKkTJcKf9Pe/23YepaqnqA1a39PcD23N8YJMF0FSNC57DO45GQFWxpjg9Sm7R/wkJf
         9WZa4L/brNaj3soTVlxkwcabBDhLCrk1mR2FlLJQd7YygnX4e04gn8EZypEIt13Le5/6
         VWRZqK6JiKugyDcEHCMaKHMmc81x99FgWLTAk1RAqPA2SLjnETyg2bYT38PGEJS/qm6g
         8jMalNS0YOKKmSdQbli2ydTmTLDk9mfEXu3N0ZDgxx8EGMoVEuejYp+HDNJFVDlA4SIL
         WRTORRhICnZY2lyVIDb9H5A8wzeF5Gcw8gCHJktYXLlOAm/oA7DFX52ljHDywzrcxp+v
         o8VA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791496090; x=1792100890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d/cxQi5bl2KO3QA7Ge7jeOTx9NRmHL08KKAX7/aHZBM=;
        b=i4XOrfKH4Z7wonh8hJEW2LlWuFXiwMClZcHlU+QZ+Ln/cvdTrcyrUybMAY43wcUmJF
         W0hxPjxHnNSlpqLJTyjIBNJnd2eDSgbVmJxgxfZ1LQakFV6wx84N7GHh3dkXEW4bSfgp
         4x4aaWZQHvZg95WZsyWNIs3jo4gk87htFQYARWHzT4GagqbaU0mT+Boct6mCoQjxpO2O
         nZZAZPLg7fcUoCk1JatmzCekIszCYakd6a9wA+zJNNOIy/NpSt0PFAawsXOrmlTMfZvC
         Lgs+JPzpvKhUvjnGTqiLFR7h/N33LazRvRK8vAinLdNh6Is/IQc6ncHfIhfr8aSxVXlZ
         aJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791496090; x=1792100890;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d/cxQi5bl2KO3QA7Ge7jeOTx9NRmHL08KKAX7/aHZBM=;
        b=n7mC7bh2FyahcxGUR1MdU6eX3CgBtI7w3jfDz6mZY3ziL/UdJpmfjKFREd7/vy6VXN
         ktxy422GBVEKL/vXlL5IZ9Q/7KUzZr9bxa4mb6kXf/WOPXK+DzKT1WaZTKq/x59ayPw9
         3mE5h5zlUbPpRPE0TXW8vnsda7LznYAxGaJDI51PmbRCESC7IDEr48NY0GTyZzK/VkUz
         8OLbFk4PFnyh4oiUq8aDSQXU2yPGiBtzsGl5tb6IT6UiFrM4eqlH+NQSci/2CYnGs99w
         8VJmQYHjlwyew4qlBuBrGOPSpU4WDRg+xImNxWMCK+ro+BNQLA9qgP15K9PS7AcOmp/4
         FRAw==
X-Forwarded-Encrypted: i=1; AKwUvBywD0m7+hY7IZvp5ez9Fx2s059ihFHUK5W89acZRdXZEKZ1wOmUH1KSveio9si6lDj88lbfO8M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYW6R6uFiCFBJ+QuG+Fg17tgl7UVEttVQFtIl2IbirLM0rkTH+
	KOnv4O6z7H3kJn7OEve2oI4kwbwNKO3PSVeIqWUueeslz+PmHsql+354xHqR1zI0B7I3tHeQkPg
	edx7yw9wgE9xZC8Ez9KGnPvK4FrBtOSM2fRoPZFRq
X-Gm-Gg: AYBFou391GBKGfIfCuYLpQcgH7QOZesuv7APw+8n7zME27iVKE6+P6FPwCDwMDPLe2l
	TvGHcwDK4WgjedgNkKlAbct8XktQvsOklWr2VZXlyhUF9I57ohINg4moLZNZ3pO8CPpT3gTOgB8
	eqGK5focOJW7+DMFmGftnmB/Yhwrg1eMZ0FzYhB8nOIZ2X5tdqW63N9N9WFeGKnUGkOrMwUa9gJ
	db3EqdbvWo6ANVetfKNLc6Y9WeygpUzB7ZSK5YtsjB/dOCYG/9PDa/JyT8xOAmgxD0ydJ82i9w7
	GafJaGGL4efqSmCnR5Ny8a5S03YvFs/Gt/3wEYGkdLs69MjBGEAgHR3gxZfMdZFr0cyF3f3MjqB
	cCch9p9cIaKQl7j2r68hGx5KHdyMa3otK3lHh++3Px8oU
X-Received: by 2002:a05:622a:5793:b0:532:9220:a9ae with SMTP id
 d75a77b69052e-5359e455c40mr1433461cf.6.1791496089446; Thu, 08 Oct 2026
 14:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL4WiipKWgA-EcFWDQd3t7nBwU7AnkLvqs6j--he-dR-SAgqiw@mail.gmail.com>
 <20261006141300.1722466-1-ncardwell.sw@gmail.com> <20261008212007.11619-1-nramaswamy@openai.com>
In-Reply-To: <20261008212007.11619-1-nramaswamy@openai.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 8 Oct 2026 17:47:52 -0400
X-Gm-Features: AclHuK9JwqNAnKKUmQkb5nbkkVlAY3vgd5ysmdQybG9TDCTGPUW7dr1Q1zAJXag
Message-ID: <CADVnQy=X6-=dBQ5xjt5r5cEnjvEWjYPxg+vn3nH481r4kFc96g@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] tcp: restore RACK list membership when undoing loss
To: nramaswamy@openai.com
Cc: Neal Cardwell <ncardwell.sw@gmail.com>, edumazet@kernel.org, davem@davemloft.net, 
	horms@kernel.org, jiayuan.chen@linux.dev, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org, 
	ycheng@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 5:20=E2=80=AFPM <nramaswamy@openai.com> wrote:
>
> From: Neil Ramaswamy <nramaswamy@openai.com>
>
> Hi Neal and Eric,
>
> Thanks for the detailed replies. Neal's approach is much cheaper than my
> original patch on a few UML microbenchmarks that I ran.
>
> I'm not entirely sure I understand Eric's usage of "often" when he mentio=
ned
> the O(1) list splice, but the metrics that I've collected from my particu=
lar
> repro seem to suggest that Neal and Yuchung's assumption about LOST but n=
ot
> EVER_RETRANS segments holds in the cases I captured, so I'd be happy with=
 that
> approach.

Great! Thanks for checking those.

> (One super nit on the runtime complexity of it: in the comment for
> tcp_tsorted_relink_skb we say that it's O(1) amortized time, but I think =
it's
> more that during partial undo all relink calls together traverse the RACK=
 list
> at most once.)

Sure, OK. :-)

> For Neal's fix, I also did write up a small packetdrill that shows that s=
egments
> that are already retransmitted and then marked LOST are not added back to=
 the
> RACK list during partial undo, as intended. Happy to contribute that if u=
seful
> for explicitly documenting that this is behavior we are okay with.

Sounds great. Please include that new test as another follow-on patch.
I agree that test would be useful to document this behavior and ensure
the expected things happen (and no bad things happen) in that case.

> How would you like to move forward here? Do you want me to fold this into=
 a v3
> patch with attribution tags or do you want to send a new patch yourself?

Please feel free to send out a v3 patch with attribution tags.

Thanks!
neal
