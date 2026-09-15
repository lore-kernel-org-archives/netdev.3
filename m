Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDAC4B4889;
	Tue, 15 Sep 2026 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474617; cv=none; b=k8f28wJEFLlduTRC7KhXKeobqPs2+7HD4SSrnc4fLNj73fYATxL3zoC22obdkf0LMtvD0m9E4JHQAdZC1h41TdDHm9MC4f98tPvhurnDYJYXKsvg1edntW6UHA5F0IZphLLNEcuCOBCnOtVol/TfLCHIYBaCCOweIEvwoBAy3cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474617; c=relaxed/simple;
	bh=oYwwYPyj7Vm7ickDza7CTYVCcgXBPu/im0Qj3+VxymU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uExO75POLEDky3a0Ns2/VSgWMs1H1fhZBkO+2dq3QmHvbmfl7xQ/lFtkoOs7eEQG4YY0vyvDyo8OOvoXAWwwzILaRxPwDOav8NUAqewYo98MBy6PJav6t0sOrHEDPeyCpoF5KVR+9CWOJwMnS6uTDlE6KI1zBRL+b9tKHVHscJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXLnHpiG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXLnHpiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF14E1F00893;
	Tue, 15 Sep 2026 12:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474615;
	bh=xsvxTNg7+N6RcaLzEAJc0zPvq2347ZkjbwHETUjpUgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KXLnHpiGk7CfpGkCip4U2TPAq+/g0jQa5XlQ3lKJEU3eNkwpiv8b4w9C968+cyVWz
	 gMVSbWYAITG0hjL+YgiwQNHbzomZ8Q4lOUzlVSPW8FlyEFITxDTn1cuBnhoIwXd6cR
	 kGI8ytqYlZ0p+EaXPwO0At83JKYnjTFGCFrCaEQFWlJrGhsuvFv6qja+KER9xYgTll
	 R/a9JXsaNa8kXbSZkKyj80WyVrR8V/CQGP9LLNwVxdO1mnPl5J8PZ5Tm6PsC/rTf0R
	 6Qfj963vZ+OuvQJOj6pvCJB18KR9DvsvKWx4VVHOchqlthHaClX7AeaPwAEeAXlgtX
	 /05N7L4XTEjvw==
Date: Tue, 15 Sep 2026 14:16:49 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, davem@davemloft.net, 
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ij@kernel.org>, 
	Wyatt Feng <bronzed_45_vested@icloud.com>, Ido Schimmel <idosch@nvidia.com>, 
	Yung Chih Su <yuuchihsu@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13 net-next] net: ipv4: disable IPv4-only sysctls when
 CONFIG_IPV4=n
Message-ID: <5khbnge53pmj5wwbmj74leflnb667qaxjztkkpje43u4vtwldn@jrtganmwzcrw>
References: <20260910144914.8025-1-fmancera@suse.de>
 <20260910144914.8025-13-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2l2o4jb7uizy3efd"
Content-Disposition: inline
In-Reply-To: <20260910144914.8025-13-fmancera@suse.de>


--2l2o4jb7uizy3efd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 04:48:37PM +0200, Fernando Fernandez Mancera wrote:
> To avoid noise and unexpected problems, let's hide all the sysctls that
> are related to IPv4 only when the kernel is compiled without IPv4
> support.
>=20
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  net/ipv4/sysctl_net_ipv4.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index f6c7b755fa7e..f86883ea0c20 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -31,8 +31,8 @@ static int tcp_min_snd_mss_max =3D 65535;
>  static int tcp_rto_max_max =3D TCP_RTO_MAX_SEC * MSEC_PER_SEC;
>  static int ip_privileged_port_min;
>  static int ip_privileged_port_max =3D 65535;
> -static int ip_ttl_min =3D 1;
> -static int ip_ttl_max =3D 255;
> +static int ip_ttl_min __maybe_unused =3D 1;
> +static int ip_ttl_max __maybe_unused =3D 255;
>  static int tcp_syn_retries_min =3D 1;
>  static int tcp_syn_retries_max =3D MAX_TCP_SYNCNT;
>  static int tcp_syn_linear_timeouts_max =3D MAX_TCP_SYNCNT;
> @@ -48,7 +48,7 @@ static int tcp_plb_max_rounds =3D 31;
>  static int tcp_plb_max_cong_thresh =3D 256;
>  static unsigned int tcp_tw_reuse_delay_max =3D TCP_PAWS_MSL * MSEC_PER_S=
EC;
>  static int tcp_ecn_mode_max =3D 5;
> -static u32 icmp_errors_extension_mask_all =3D
> +static u32 icmp_errors_extension_mask_all __maybe_unused =3D
>  	GENMASK_U8(ICMP_ERR_EXT_COUNT - 1, 0);
> =20
>  /* obsolete */
> @@ -199,6 +199,7 @@ static int ipv4_ping_group_range(const struct ctl_tab=
le *table, int write,
>  	return ret;
>  }
> =20
> +#if IS_ENABLED(CONFIG_IPV4)
>  static int ipv4_fwd_update_priority(const struct ctl_table *table, int w=
rite,
>  				    void *buffer, size_t *lenp, loff_t *ppos)
>  {
> @@ -214,6 +215,7 @@ static int ipv4_fwd_update_priority(const struct ctl_=
table *table, int write,
> =20
>  	return ret;
>  }
> +#endif
> =20
>  static int proc_tcp_congestion_control(const struct ctl_table *ctl, int =
write,
>  				       void *buffer, size_t *lenp, loff_t *ppos)
> @@ -439,6 +441,7 @@ static int proc_udp_hash_entries(const struct ctl_tab=
le *table, int write,
>  }
> =20
>  #ifdef CONFIG_IP_ROUTE_MULTIPATH
> +#if IS_ENABLED(CONFIG_IPV4)
>  static int proc_fib_multipath_hash_policy(const struct ctl_table *table,=
 int write,
>  					  void *buffer, size_t *lenp,
>  					  loff_t *ppos)
> @@ -469,6 +472,7 @@ static int proc_fib_multipath_hash_fields(const struc=
t ctl_table *table, int wri
> =20
>  	return ret;
>  }
> +#endif
> =20
>  static u32 proc_fib_multipath_hash_rand_seed __ro_after_init;
> =20
> @@ -490,6 +494,7 @@ static void proc_fib_multipath_hash_set_seed(struct n=
et *net, u32 user_seed)
>  	WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.mp_seed, new.mp_see=
d);
>  }
> =20
> +#if IS_ENABLED(CONFIG_IPV4)
>  static int proc_fib_multipath_hash_seed(const struct ctl_table *table, i=
nt write,
>  					void *buffer, size_t *lenp,
>  					loff_t *ppos)
> @@ -515,6 +520,7 @@ static int proc_fib_multipath_hash_seed(const struct =
ctl_table *table, int write
> =20
>  	return ret;
>  }
> +#endif
>  #else
> =20
>  static void proc_fib_multipath_hash_init_rand_seed(void)
> @@ -634,6 +640,7 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dointvec
>  	},
> +#if IS_ENABLED(CONFIG_IPV4)
>  	{
>  		.procname	=3D "icmp_echo_ignore_all",
>  		.data		=3D &init_net.ipv4.sysctl_icmp_echo_ignore_all,
> @@ -643,6 +650,7 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.extra1		=3D SYSCTL_ZERO,
>  		.extra2		=3D SYSCTL_ONE
>  	},
> +#endif
>  	{
>  		.procname	=3D "icmp_echo_enable_probe",
>  		.data		=3D &init_net.ipv4.sysctl_icmp_echo_enable_probe,
> @@ -652,6 +660,7 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.extra1		=3D SYSCTL_ZERO,
>  		.extra2		=3D SYSCTL_ONE
>  	},
> +#if IS_ENABLED(CONFIG_IPV4)
>  	{
>  		.procname	=3D "icmp_echo_ignore_broadcasts",
>  		.data		=3D &init_net.ipv4.sysctl_icmp_echo_ignore_broadcasts,
> @@ -702,6 +711,7 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dointvec
>  	},
> +#endif
>  	{
>  		.procname	=3D "icmp_msgs_per_sec",
>  		.data		=3D &init_net.ipv4.sysctl_icmp_msgs_per_sec,
> @@ -772,6 +782,7 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.extra1		=3D SYSCTL_ZERO,
>  		.extra2		=3D SYSCTL_ONE,
>  	},
> +#if IS_ENABLED(CONFIG_IPV4)
>  	{
>  		.procname	=3D "ip_dynaddr",
>  		.data		=3D &init_net.ipv4.sysctl_ip_dynaddr,
> @@ -779,6 +790,7 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
>  	},
> +#endif
>  	{
>  		.procname	=3D "ip_early_demux",
>  		.data		=3D &init_net.ipv4.sysctl_ip_early_demux,
> @@ -809,6 +821,7 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.extra1		=3D SYSCTL_ZERO,
>  		.extra2		=3D SYSCTL_ONE,
>  	},
> +#if IS_ENABLED(CONFIG_IPV4)
>  	{
>  		.procname	=3D "ip_default_ttl",
>  		.data		=3D &init_net.ipv4.sysctl_ip_default_ttl,
> @@ -818,6 +831,7 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.extra1		=3D &ip_ttl_min,
>  		.extra2		=3D &ip_ttl_max,
>  	},
> +#endif
>  	{
>  		.procname	=3D "ip_local_port_range",
>  		.maxlen		=3D 0,
> @@ -839,6 +853,7 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_do_large_bitmap,
>  	},
> +#if IS_ENABLED(CONFIG_IPV4)
>  	{
>  		.procname	=3D "ip_no_pmtu_disc",
>  		.data		=3D &init_net.ipv4.sysctl_ip_no_pmtu_disc,
> @@ -869,6 +884,7 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
>  	},
> +#endif
>  	{
>  		.procname	=3D "ip_autobind_reuse",
>  		.data		=3D &init_net.ipv4.sysctl_ip_autobind_reuse,
> @@ -878,6 +894,7 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.extra1         =3D SYSCTL_ZERO,
>  		.extra2         =3D SYSCTL_ONE,
>  	},
> +#if IS_ENABLED(CONFIG_IPV4)
>  	{
>  		.procname	=3D "fwmark_reflect",
>  		.data		=3D &init_net.ipv4.sysctl_fwmark_reflect,
> @@ -885,6 +902,7 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
>  	},
> +#endif
>  	{
>  		.procname	=3D "tcp_fwmark_accept",
>  		.data		=3D &init_net.ipv4.sysctl_tcp_fwmark_accept,
> @@ -950,6 +968,7 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.proc_handler	=3D proc_douintvec_minmax,
>  		.extra2		=3D &u32_max_div_HZ,
>  	},
> +#if IS_ENABLED(CONFIG_IPV4)
That is a *lot* of #if IS_ENABLED....#endif.

Is it possible to just have one #if...#endif and put all the related IPV4 s=
ysctl
together?


>  	{
>  		.procname	=3D "igmp_link_local_mcast_reports",
>  		.data		=3D &init_net.ipv4.sysctl_igmp_llm_reports,
> @@ -980,6 +999,7 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.proc_handler	=3D proc_dointvec_minmax,
>  		.extra1		=3D SYSCTL_ONE
>  	},
> +#endif
>  #endif
>  	{
>  		.procname	=3D "tcp_congestion_control",
> @@ -1152,6 +1172,7 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.proc_handler	=3D proc_tfo_blackhole_detect_timeout,
>  		.extra1		=3D SYSCTL_ZERO,
>  	},
> +#if IS_ENABLED(CONFIG_IPV4)
>  #ifdef CONFIG_IP_ROUTE_MULTIPATH
>  	{
>  		.procname	=3D "fib_multipath_use_neigh",
> @@ -1187,6 +1208,7 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_fib_multipath_hash_seed,
>  	},
> +#endif
>  #endif
>  	{
>  		.procname	=3D "ip_unprivileged_port_start",
> @@ -1561,6 +1583,7 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.proc_handler	=3D proc_dointvec_minmax,
>  		.extra1		=3D SYSCTL_ONE
>  	},
> +#if IS_ENABLED(CONFIG_IPV4)
>  	{
>  		.procname	=3D "fib_notify_on_flag_change",
>  		.data		=3D &init_net.ipv4.sysctl_fib_notify_on_flag_change,
> @@ -1570,6 +1593,7 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.extra1		=3D SYSCTL_ZERO,
>  		.extra2		=3D SYSCTL_TWO,
>  	},
> +#endif
>  	{
>  		.procname       =3D "tcp_plb_enabled",
>  		.data           =3D &init_net.ipv4.sysctl_tcp_plb_enabled,
> --=20
> 2.55.0
>=20

--2l2o4jb7uizy3efd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqpNzEACgkQupfNUreW
QU880Qv+Ny9uaMhwRKmfiUdaoltZv5j23je9XH7iTyWJOpbl6qOrRdhuUBh4GWUL
fwRn8VoxxV0MWV2jM3UQmy6pIT67d+2Z18r7DTP5U2dad4ueibMcQiV7kRkhUZLW
piO9L0U3ouP3C4p6TuLX/SzjhIEZB+aoOeAOCgJ7v667pZhYHsArZXy+oLzEufjR
RCKo/4po4W/q1Vd+NW0B1loT/+sf7JH1Wl+eMBjJu3cii3Fb30XU1cQ0ylA/J++O
qsZBs9n3ZyP84gwJCSSdSVSsuKAEjLrJ6vaW9zwtxgmD02hZ8k/4wcoFuZKgoD4q
2RhUcFPMf/6c+jgmKQ0mgzRVPpL576zhNB/aB5ewJsolx1SfO+YCZvYHdFydqeKF
c0k7TqRCdR80rpGuWC3Ty2AimDInn+um2Rk2JrTHiuF7WrJz6MI/gUf6jsV7Wq/h
MF9kKRIa+XhFBWFxlyKNPlXsLqcEKbbwJzAH1yDhZ1XwAQuK3nCdKNWzLRqBQaD8
s6CGs0Z0
=r/Er
-----END PGP SIGNATURE-----

--2l2o4jb7uizy3efd--
