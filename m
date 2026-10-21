Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792549460;
	b=Kpybv48+RuH21mlaBBxKEEUz0Oe3Ac5Y0aQBeFPxwFlcIa4VLK2lw55wvMwujkXqai3D
	 YIV+EInNlfVzpj6uezfaHS9qefpZ6EhliKPhaFbKXeft/IaiR7gz5WNDPHfxbzEuuK1gp
	 b5jEddpLtr5T19aqRD+SjaSzyLbBvXLOMLKSM1oqkfhDKeqBEThd/x3EGTpCjHjjKMOgw
	 rwF8kHrhTISuiujIv6cc+oNvrsE0nx61f/0j7NI/9wKpPaoJkP1UNzpJBql9jwDMw33xp
	 WARpw1p9WocQpILBH21/hTt2tWAZVnBp80mHm8/ONmteipqgZQZn+YEjcQNk9WUvzVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792549460;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZAwKv5291S60ww6ab9qXZH4XI1cL7qyN/nJYUmNoKYs=;
	b=FfA4dypd/klMaqJZoBvSNDt/66W/WloWojvYQaYiQcFCSrEJytQjV6ycWcSSy0RZlu3m
	 j+IGMIDoZLAiTRBycNVqOeKDP8jHovouGcNLelONm1gq2l2KPs5M6xyrbAe2keAnEaQd/
	 Sw3teQb7vsaOKFO/2MnDMToNBKu32d+B3qEw7Q1rRthn+xpvf36YR0YP7ameieJwFMQuA
	 bDvkuqizuqfADKH+PQyC2O7uacRtCxKJibGDMjnHrkMfIUmh+EFZgAUHpJj58AwZ+fuC7
	 wZR73dO7lCyiyO7dG+XKN/kXN64xQVyKzR/oOmEq39oxQOJ+sz2SKY7YsdQSG9+Jwiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ae2tcljp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E70D606A319;
	Wed, 21 Oct 2026 02:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ae2tcljp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CBB1F000C9;
	Wed, 21 Oct 2026 02:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792549460;
	bh=ZAwKv5291S60ww6ab9qXZH4XI1cL7qyN/nJYUmNoKYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ae2tcljpRbNPD85B63KfiWmXX0Vg3Ug3/1slqGxtek+Tc5a2eLUfBJ0Kx8Cqndly7
	 SnsLfmAqLERObiM4L1ZAcOzog5RIPmksKwDjhUTQmr6x99i3bpwSugBb7l32npMroD
	 tWhwnTkW9XuXPBIJpBgcJXnneKq6dunem/u6tjed5EnH6jhhDW7i5CQ5IyCAkD0BCm
	 9npYlabSGYiDTXVWUuMFhNRYoHjLMRKrHFFje0MlJPaczN+tjpqvAxeNE/t/wSIhmQ
	 JqzfI0RQiaD4ICNxzfVBTNXMgnyCRSu0ZE+2BN2th8fnNYYgfymbzToSAFE53FKipF
	 /aeckeZW+6iyw==
Date: Tue, 20 Oct 2026 19:24:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Miguel =?UTF-8?B?R2FyY8OtYSBSb23DoW4=?= <miguelgarciaroman8@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 syzbot+44efda9647c52be29d9c@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] llc: shut down timers before dropping SAP and
 device references
Message-ID: <20261020192419.2c742101@kernel.org>
In-Reply-To: <CABKbRoJw5SOQH6ydjxyi9j4k2uhjnDSwN2dOpzCAGsFeJZ0bJw@mail.gmail.com>
References: <CABKbRoJw5SOQH6ydjxyi9j4k2uhjnDSwN2dOpzCAGsFeJZ0bJw@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Oct 2026 08:16:17 -0500 Miguel Garc=C3=ADa Rom=C3=A1n wrote:
> Subject: [PATCH net v3] llc: shut down timers before dropping SAP and dev=
ice references

This code has been deleted.
