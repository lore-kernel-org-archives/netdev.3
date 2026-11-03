Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793677995;
	b=K0eerC+EikXbRH1OvFzr9hmKPG05XONQQNBYxPz7EUIw+k/4otvQwqVMsJZZwPtHyA+9
	 ll3dwnBTHiyMJ5jXSkyz2E7pqjkLVeB7HlouOE7voqn/xsXaBYlh9A01CmNdqsjmf0LMa
	 BbJt2Eelu7RUi+tobtf8FKajrEApvvVK0SdxGP4kxddPM+W9Ff5i7/NesR1LBVM56ZHMK
	 qZmMT7i99rmaZbYDFM64JVZVfLqsLoB4DKJVClQk+N7Ytiz66xcCCJciNqe9QbtZWk1Kp
	 BPnRPuFsVEONaoWEbih4cwHM7bdwcLaMdY30on5FvFaye5rxZf5xhmVbWZJcx6zdYWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=76gGkTqtaYNNNNFBCSrtmRbRqlON+bEYckw0E/pLtHM=;
	b=hs4GZjIsWmvIVpp25ZZA5LJH2BYiI4cOdKa6SzShPRvR0OyBpvARz++GhWD8Wr84ZvQo
	 DtPktfaroOu4dkGRV72AHtdeRO3yLG2Z95A+QPMfNVe9KJ9wzDvL5PlGD0OF+c2OP8BPo
	 nFlKweLJY/cWCUfaaJ9xbUAn7i+HWni04aitygnMaW+SzBgkGjig1zuyEEYAambN6dkWn
	 8iqi/VVgGQ5jyUbqqI7VcD7+o8izqUm+tbp/YqJnalAJQLwpOieATi7jkPlDq7G4mrM76
	 RBo+Kiohdldf/deE/xUsqMQ0UFpCHfX6kTYVfx79t9z6CZr+qrHw3af2nWbTnrZoMmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L8M14MOc;
	arc=fail smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC2D606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 03:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AC2D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L8M14MOc
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-854b6e2e41fso2359849a34.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 19:53:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793677993; cv=none;
        d=google.com; s=arc-20260327;
        b=ppNjGum14ENxiqTfzx7XtZLzraGzBuaBZqbJy/0c3jblRah+9AF+WLcbd/Z/JxSMVb
         xH89xvAlkngI9rPhwaoWenmUwEzkC6t9cgffmXd1v//4Qs1IxWf6RBZUHVfHkzpG2la3
         o8lML7aXFiPmiSsymudZkaASdaGRDnT/vnGe/KmVWSQctjLOhXpzofV0GJigJixoHH+q
         +VMVups3W7ymPGls7o8DBVCwb9/8stxvPI/sI3ZAoIFLHAoGWN1C8uu3U4Xc7gkuSfkc
         SSOugOrjlgsWHbvU1VVOZAElVafMZe3iOKS0X7kQvXWivb+EfQtF4QZnsvmUYXa522WQ
         7wWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=76gGkTqtaYNNNNFBCSrtmRbRqlON+bEYckw0E/pLtHM=;
        fh=YGPmnbT5iHb84eZ/YeHcCo1+/rX48SlK194wGLbQIU0=;
        b=fU4GWkExMV6j9VygRLMVZ6zc9GdGjojTHyXZY+wuyTtrgbAYXP+svskh6Ytncshzur
         35cKr5HVnMQ05oxI3VpztxHxIlg/kfZYvrtmrT/efIdl/wSyrFAmLg8hCiZPdg5k3W87
         d2Jw7qYqJGjKX1ozqlCyd3cuuEpn6oGZgCmGQvJg1qUNKs3EEL9qLziym0noRgOdPgkp
         DHjKgELmD2thRl9D1NMS1vaZNDlTdAx2QyAugtkjrJdxQuGljUwaKCSYCsfgloKWWovb
         NOq5D6SC3zIhC7KYvl4BNy0Z35lCyj2ry8LnED1VxXxQusdwoOO0W/fJO0qQ0lbzS/EL
         Tzsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793677993; x=1794282793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=76gGkTqtaYNNNNFBCSrtmRbRqlON+bEYckw0E/pLtHM=;
        b=L8M14MOcaJpc76OWDxueRVeV9C76b9r6Uyd4M4brK6+onw8iS562oijlRkYcOcg9+A
         bRbNUSU5ECIR+C1nk0mTlcuGzqkl4Stv/cQETFnptUt/0THXr20WveLjDpKlo4GyhJru
         aAzNt33KHggSYCDrq89yRI/UR0DyJYa1eEbkn+ykL9jI4VJv3csyJIx55u+e8nfi+74T
         Jvx+tWN7mC7W9F97bsFCNKioR9S/QYN7FwHbRNPHCUd9Z4hDU9FEkRSryD3zC4rIA1/4
         b9di7HEURgISJRWIur1UffdAdvYhrVJOreZJ8EQIDMNTNZa+9b+3/sjButhG7ZLwr8bJ
         VtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793677993; x=1794282793;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=76gGkTqtaYNNNNFBCSrtmRbRqlON+bEYckw0E/pLtHM=;
        b=lRgo9KF9Q8CKvcFdQullC0UtmMNexY0loin/PHngmVZ+HoniZBS1W92ONz8mpLGWsK
         CvS8S8piCJX5HXxx8eTA5Y3/hcVLPm+uxYBEmAXjmNKuyEepDFUFQQVzVHtkExg6VnbN
         cufvIrWy3ImzsBI0J8bKlqCdsTE+bAJ4XTP9l+F7BJd0O0WmtUd7TnQcSLl17KOGQkNx
         rUMsZwEbPi6h+nkm6Qnr3fiiVGqhwq6QJTR3cD2TWv4tLAWrYN2nFmnxkSsEBwIFpy5t
         TMZ+M2zc05DFiyrhJ5ICm/TJZtbCc1CXs4DXxIw491md5XZ+TIXr8V5dUad1XLpgTvNt
         p8jQ==
X-Gm-Message-State: AFq9FYK87oFvMqXgRo7pM0C22HGM+oDXKCXsxfdcSuMe3HK/SS3cEZDB
	itTPChvbRC/veiUN6XV5QjdidilN8hd5bdpZAsUPCnL9s88ZusvebgUz4E1i0PH+d5Zx41r3aLB
	1tOSUqZ9oq9t4xIkKnXSxPzTNnJzY+Fc=
X-Gm-Gg: AYBFou39lEOZ4bSHDaaKAMuAvRftgiJZvBOhR72R8A3sVwjxPMek39PKldggowvUhDi
	EsV64uTmu/kDxb31scuB1AFU0/Lbz9RFKbH+Riom3ZdJhIAr0C5SUZ4iuMHOxc7P3u6EfXXacyd
	trTtEjhRPoAXKAEfLhmaa3KR7IUyWqpC1nD7pyqo8bmDVUT3/1zns3n6PhiJ3TQymm91ZqjDcT2
	eJv9h24NqD0tptKFlfAUsAse3nEPOtfivDkBaIqSf8LbuhTQZRym9jHfY68Kfj5vQso0xTDNb2s
	fcsIWVUY5F5cxmA4XrprU9BvnUtXWBn7RJk8LyhMAcOD5Mlw8gOn+yTJYQheZqL7yYatRrLNUsy
	IP1PLwU2RQ1aAGqcEdKxZJtHrm4j1v69uiRmTmFphYXPMuIvoPKu9Jg9uu1iLkTLKrSlodC0=
X-Received: by 2002:a05:6808:2218:b0:55c:95a:f10f with SMTP id
 5614622812f47-5640de58220mr8255866b6e.52.1793677993492; Mon, 02 Nov 2026
 19:53:13 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102101125.3523835-1-mmyangfl@gmail.com> <68a1d47b-e3a1-4353-82a0-89fb2d387f2b@lunn.ch>
In-Reply-To: <68a1d47b-e3a1-4353-82a0-89fb2d387f2b@lunn.ch>
From: David Yang <mmyangfl@gmail.com>
Date: Tue, 3 Nov 2026 11:52:37 +0800
X-Gm-Features: AclHuK8IWE7V-kEZ0tfbWmZ_cNA8A7q4Hv7g79t9Ud229ArsBBITMxgYp0K1bVQ
Message-ID: <CAAXyoMOsu0kL9Y=7+BhDizgUbF+tY+i51vdNpeZ6KhQAPovvcg@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: motorcomm: Clear the MIB buffer on chip reset
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 12:44=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Nov 02, 2026 at 06:11:21PM +0800, David Yang wrote:
> > .setup() can run again within one registration: removing another switch
> > from the tree tears the whole tree down
>
> Is D in DSA supported by the Motorcomm devices? Or is this tree always
> a single node?
>
> > Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921=
x")
>
> What i'm trying to understand is, is this theoretical, but never
> happens? If so, it should be based on net-next. Or is this an issue
> which actually bothers somebody and so is justified having a Fixes:
> tag and posted to net?
>
> This is also what that automated email is about. We need information
> to decided if the correct tree has been picked. It frequently is wrong
> in the LLM age.
>
>    Andrew

Motorcomm does support cascading, but not in our driver. So yes, this
is largely theoretical and I just follow what sashiko said.
