Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48493486631;
	Wed, 29 Jul 2026 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785330858; cv=none; b=I/0HXJ5S7XhGDLHSmU+8gp1/xAmsQ/IvQEIraoUEUgosgIRiUJjMrTGPzO9RgI7CyRHtms0/AP56Z2pzX+yEk/V0qIx7RsyOSY1Iq5N7tNecJwC7ukLm047KPhznLg4Ge8cDMYjP9rgYHyslLO7/42z/I4OnQnLmHN8OKhuuH50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785330858; c=relaxed/simple;
	bh=C1O3S9T7lAA6q6Z0iZeGMINMeO8DXktjesQYoXYUmmc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iSdRlC0QaQcbZ2is60Rdbq32lRDNOkbiNKEPuO2z5Piwxdy8ZyizDYBZs2Fb+nuylRpiB4lTCfnaU5+PhUBI6spu+9E3uplM/R3AWOJYd/4iLy+TXGBTtYmiy2PzN+cbgirjpx7p66yxOXDBkUP38nSeUqA/60X2G8RO9f3meKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRnANXlL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRnANXlL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EC81F000E9;
	Wed, 29 Jul 2026 13:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785330856;
	bh=C1O3S9T7lAA6q6Z0iZeGMINMeO8DXktjesQYoXYUmmc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=dRnANXlLflmY60yeY6QlCEHfTaL+6ul/FpJrxoHhBJ3uts5ZW5jQU9h4qzHehOZoB
	 R/ZthnC5eKbbH0Zu0lkGNIfu5zJznEKwxqfVsTw1U5ottRKMsb3h3NscKio8rS9vpY
	 R74PsL+ku7nX6tgWfef2i5DfigelmpgWqvKIiHdZ6hWSOwigoFCuBB1XG9onCMbpuk
	 jv41JL+lO3YMLCIYZJdRKmIr4XZ1Dr+nM/tBvzaVdN0oY8nwQ287EK2lt2JupBfpaR
	 bwcA/lJeIAY0sT97WGI4HlsXzLsCxH7fLvzMeb0zT8WqT0/KS61C+di0HU7Q3QHB1L
	 CvJ9BP6RlQKaw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id A7225F4006F;
	Wed, 29 Jul 2026 09:14:15 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 29 Jul 2026 09:14:15 -0400
X-ME-Sender: <xms:p_xpagLKwV26FIcSCEV6kS6QEJnb1Y3bVOTpiwQYsmphTe2bXtE-Gw>
    <xme:p_xpaq-iZ9iGgWwLiD0qbWJ6a26Gy_QI4aD2x3uSDR5EcmhtyKJlzlzZwnkDOL3Rs
    AUcD8WDToviEPXS4t7cfnaDxWoRLz7rJxKrFm9fEXCLJeplPp98vfkm>
X-ME-Proxy-Cause: dmFkZTGEoTIjlYcV++Q9tJt0LGVCaHSiJhlyuRn73LL0pmntnHkUwQYd0WiF0xd+FF/a/U
    NpuZeydx5yfUYeRW9OreiZBCL1h9SYh4dQSeyl3U/ki8hYCSbfoxNPQne80nt4/nwQ3Qhl
    vh/wflsL1EWZ+zrjFNyY5cNIJ4XZk3XU7YKYn5vA1ka5YLlAUZansUsVNGiMOCM2y+Xp+R
    9n17MQRDmNWxmDHhZiev4SWOkoFuSqaFvJA5jgNW9kClbm+wRxVXqd8R2JcKPbzkicqh0c
    LIn7cPvksCztrVmGPeoZ441/YsNZDFr9deuxL1gGn6pdiwzGG0vrKSlK8+yPfTPyCpHHez
    pKXlJDF4cQ1ECA84JQN4JcEMSKFlLI18XaTCnuaeI2Ic42X+wlO/ozZ1Z25AoVou+tzFIN
    QOw24b+vnpl9JgMkohbvQLLVJaC/EW0B/8a2fxVR0F0ufAGcsb7T42ddMj5AwMIafcb4PU
    Q0xEY8k7wMUsTe1cqXqXMRoH6GIF7ajhETjYdm6VZWl2k/H0JWdlTqqtZ8lM2TxchMKjTN
    h2z70jpWsyYlg6gQPZyWu/SVUjesqCAFOvQX5Mb6Dt5YcG7jDOXTFkIDLm00Ms9muB+Ohk
    W4DGrWrwdkkHe+CJay3CnwOGyhLNm/TmskNmih2x6JkFbnkrcdJU/0Hjn7wg
X-ME-Proxy: <xmx:p_xpaoFCymrU9lF2uecN1O3GamKNIDey20AWrPG1jdZqDJKVVWal4w>
    <xmx:p_xpapNBdXeoCnXSKkWrY_8U5oITFCCN6J73H3QbLU6L7xSpUq0DFw>
    <xmx:p_xpahhdDtdc9nbZRrYMbD1jR7nAezpnc8-ImS2vC7sWajO35kZr9Q>
    <xmx:p_xpah27Mi9NO4SFg2dY3RhDTEqTErYAjn-Nkh5e65H3M16DDf1fzA>
    <xmx:p_xpamn39zA-L-hVr1gS4LDyWgbDCgo4xtkigN--Ea6GbHhuR3tc4dm1>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 88501780070; Wed, 29 Jul 2026 09:14:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ao_Ba7jWoOG-
Date: Wed, 29 Jul 2026 09:13:55 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Sabrina Dubroca" <sd@queasysnail.net>
Cc: "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Shuah Khan" <shuah@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-nfs@vger.kernel.org
Message-Id: <3d0d0566-ac93-4cff-8ce5-d5637ee60b90@app.fastmail.com>
In-Reply-To: <amnwsWrxv6KvrZ_L@krikkit>
References: <20260720-tcp-read-sock-v2-0-29545d034f3c@kernel.org>
 <20260720-tcp-read-sock-v2-2-29545d034f3c@kernel.org>
 <20260728185124.72e421c8@kernel.org>
 <480a8337-a91e-40e5-8dbd-d165599fba4b@app.fastmail.com>
 <20260728193058.7f6b453b@kernel.org>
 <a6fb364d-8344-408e-bcd5-0cee4ffabdc3@app.fastmail.com>
 <amnwsWrxv6KvrZ_L@krikkit>
Subject: Re: [PATCH net-next v2 2/6] net: Introduce read_sock_rectype proto_ops for
 control record delivery
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Wed, Jul 29, 2026, at 8:23 AM, Sabrina Dubroca wrote:
> 2026-07-28, 22:51:30 -0400, Chuck Lever wrote:
>> On Tue, Jul 28, 2026, at 10:30 PM, Jakub Kicinski wrote:

>> > You just need to try a little harder to produce a better solution.
>> > Rework or augment existing callbacks to let your achieve the behavi=
or
>> > you want.
>>=20
>> My original approach was to add a new read_sock variant because I
>> suspected you wouldn=E2=80=99t want read_sock itself to grow another =
argument.
>
> Given that there's only 2 existing consumers of read_sock (strp and
> nvme, and I'm not sure why strp/sockmap use it at all) [1], and 3
> arguments to read_sock, adding an argument would be ok IMO. The
> implementation (tls_sw_read_sock/tls_sw_read_sock_rectype) ends up
> being a small wrapper around a function that does the actual work with
> a NULL check, might as well propagate that to the callers.
>
> For me the problem is more that this new argument is very specific to
> TLS, and dropping something TLS-specific in a generic API (struct
> proto_ops) is quite ugly. If we want to make this generic, we're back
> to cmsg (or something cmsg-like).

Fair enough.


--=20
Chuck Lever
