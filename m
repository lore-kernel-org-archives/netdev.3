Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E169F395ACD;
	Tue, 29 Sep 2026 07:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666060; cv=none; b=kdSbLJY66ykfY5VPYbGGepjgMqLkX9jPe8O9yXPuOH7a7FXlBRvxAf1plTpgzzGad2qV5lf3pCvCShcCt8wdli6EpTT8UO5dQB8aschUYcAcTZa7m2snCEQIm4XGsdhJkQrHXY942t/U6HnsBlUzHUBnvGE6I6RFkxiphNoD6qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666060; c=relaxed/simple;
	bh=8Qc49OmWk6n+simB3dvK+eHRxQjsQWR3pOOko9xVKlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qk+mUPQ62Ydw8GrHiKsRyo4WrPIksM1dK9yDOOV86To4TVFNOFpmbbU/C02CSe0tRI3KszXIIb+fe8Zj+God+jaSGsGdvpoEsVqzZrt2OAnA9RiVbapcecXvRD6YnHQAdp0iP3oNxOym7//yqSQkc9aKBBikN9hEY8Cn18U9PHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzpS3JhK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzpS3JhK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3F31F00893;
	Tue, 29 Sep 2026 07:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790666058;
	bh=vlTtU5v/G9tTWinxE9AmP7Lwa9ti5MICQXLzknceGiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dzpS3JhKgmhW2LpXcVJVgKeDyb7ZE8PQKCNMCzd232Yxffub9JjuYRh4UOANttXp1
	 yOhPlOvbdjiftgGW5mvneAWwCOp4tdx+bcCsGOcJoKufiAnOeNrJouBlcvWRKACdJu
	 nBoRMDS2Z0bfELOpNAXRuNCFrOEdyGrS4p/eWW8xczPAmKC9ozRuSyHxczJ+C2ZuUb
	 lKefo/mFFzhiX/B/Pja8c6oI0KyZdAt+XkW2hP42Aw1JOrzkuux2/I8CqsfXEwUmVs
	 uzN1sTbn3U8Ga7OG4ogr++3GW3TiV3+l3zBpqYKIalh6aUaEaM9fVUzbBzjkMdKG4m
	 f/LLR35uv/bUA==
Date: Tue, 29 Sep 2026 09:14:13 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	Wyatt Feng <bronzed_45_vested@icloud.com>, Yung Chih Su <yuuchihsu@gmail.com>, 
	Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/16 net-next v2] ipv4: disable IPv4-only sysctls when
 CONFIG_IPV4=n
Message-ID: <merysy6sadsrrmkiswnxlaohuftbvtaslbqhdhg5o57a7fxnkd@fkjcxi2cv2zs>
References: <20260928193046.6698-1-fmancera@suse.de>
 <20260928193046.6698-12-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7zrdf2x4soilcfnf"
Content-Disposition: inline
In-Reply-To: <20260928193046.6698-12-fmancera@suse.de>


--7zrdf2x4soilcfnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 09:30:07PM +0200, Fernando Fernandez Mancera wrote:
> To avoid noise and unexpected problems, let's hide all the sysctls that
> are related to IPv4 only when the kernel is compiled without IPv4
> support.

You are hiding the IPV4 sysctl with "#if IS_ENABLED(CONFIG_IPV4)" inside
the sysctl_net_ipv4.c file. That is confusing as I would expect all
sysctl_net_ipv4.c to be ipv4 specific. Wouldn't it be cleaner to just
have an "ipv4" sysctl file and compile that when CONFIG_IPV4 is enabled?

I might be missing something obvious as I just got to see 3 patches of
the series. Ignore, if this is addressed at some other point.

Best

>=20
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  net/ipv4/sysctl_net_ipv4.c | 407 +++++++++++++++++++------------------
>  1 file changed, 205 insertions(+), 202 deletions(-)
>=20
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 0e7fef5973db..6096e9e4d82d 100644
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
>  static int tcp_min_rcvbuf =3D 4096;
> @@ -201,8 +201,9 @@ static int ipv4_ping_group_range(const struct ctl_tab=
le *table, int write,
>  	return ret;
>  }
> =20
> -static int ipv4_fwd_update_priority(const struct ctl_table *table, int w=
rite,
> -				    void *buffer, size_t *lenp, loff_t *ppos)
> +static int __maybe_unused
> +ipv4_fwd_update_priority(const struct ctl_table *table, int write,
> +			 void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	struct net *net;
>  	int ret;
> @@ -441,9 +442,9 @@ static int proc_udp_hash_entries(const struct ctl_tab=
le *table, int write,
>  }
> =20
>  #ifdef CONFIG_IP_ROUTE_MULTIPATH
> -static int proc_fib_multipath_hash_policy(const struct ctl_table *table,=
 int write,
> -					  void *buffer, size_t *lenp,
> -					  loff_t *ppos)
> +static int __maybe_unused
> +proc_fib_multipath_hash_policy(const struct ctl_table *table, int write,
> +			       void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	struct net *net =3D container_of(table->data, struct net,
>  	    ipv4.sysctl_fib_multipath_hash_policy);
> @@ -456,9 +457,9 @@ static int proc_fib_multipath_hash_policy(const struc=
t ctl_table *table, int wri
>  	return ret;
>  }
> =20
> -static int proc_fib_multipath_hash_fields(const struct ctl_table *table,=
 int write,
> -					  void *buffer, size_t *lenp,
> -					  loff_t *ppos)
> +static int __maybe_unused
> +proc_fib_multipath_hash_fields(const struct ctl_table *table, int write,
> +			       void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	struct net *net;
>  	int ret;
> @@ -492,9 +493,9 @@ static void proc_fib_multipath_hash_set_seed(struct n=
et *net, u32 user_seed)
>  	WRITE_ONCE(net->ipv4.sysctl_fib_multipath_hash_seed.mp_seed, new.mp_see=
d);
>  }
> =20
> -static int proc_fib_multipath_hash_seed(const struct ctl_table *table, i=
nt write,
> -					void *buffer, size_t *lenp,
> -					loff_t *ppos)
> +static int __maybe_unused
> +proc_fib_multipath_hash_seed(const struct ctl_table *table, int write,
> +			     void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	struct sysctl_fib_multipath_hash_seed *mphs;
>  	struct net *net =3D table->data;
> @@ -636,15 +637,6 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dointvec
>  	},
> -	{
> -		.procname	=3D "icmp_echo_ignore_all",
> -		.data		=3D &init_net.ipv4.sysctl_icmp_echo_ignore_all,
> -		.maxlen		=3D sizeof(u8),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dou8vec_minmax,
> -		.extra1		=3D SYSCTL_ZERO,
> -		.extra2		=3D SYSCTL_ONE
> -	},
>  	{
>  		.procname	=3D "icmp_echo_enable_probe",
>  		.data		=3D &init_net.ipv4.sysctl_icmp_echo_enable_probe,
> @@ -654,56 +646,6 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.extra1		=3D SYSCTL_ZERO,
>  		.extra2		=3D SYSCTL_ONE
>  	},
> -	{
> -		.procname	=3D "icmp_echo_ignore_broadcasts",
> -		.data		=3D &init_net.ipv4.sysctl_icmp_echo_ignore_broadcasts,
> -		.maxlen		=3D sizeof(u8),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dou8vec_minmax,
> -		.extra1		=3D SYSCTL_ZERO,
> -		.extra2		=3D SYSCTL_ONE
> -	},
> -	{
> -		.procname	=3D "icmp_ignore_bogus_error_responses",
> -		.data		=3D &init_net.ipv4.sysctl_icmp_ignore_bogus_error_responses,
> -		.maxlen		=3D sizeof(u8),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dou8vec_minmax,
> -		.extra1		=3D SYSCTL_ZERO,
> -		.extra2		=3D SYSCTL_ONE
> -	},
> -	{
> -		.procname	=3D "icmp_errors_use_inbound_ifaddr",
> -		.data		=3D &init_net.ipv4.sysctl_icmp_errors_use_inbound_ifaddr,
> -		.maxlen		=3D sizeof(u8),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dou8vec_minmax,
> -		.extra1		=3D SYSCTL_ZERO,
> -		.extra2		=3D SYSCTL_ONE
> -	},
> -	{
> -		.procname	=3D "icmp_errors_extension_mask",
> -		.data		=3D &init_net.ipv4.sysctl_icmp_errors_extension_mask,
> -		.maxlen		=3D sizeof(u8),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dou8vec_minmax,
> -		.extra1		=3D SYSCTL_ZERO,
> -		.extra2		=3D &icmp_errors_extension_mask_all,
> -	},
> -	{
> -		.procname	=3D "icmp_ratelimit",
> -		.data		=3D &init_net.ipv4.sysctl_icmp_ratelimit,
> -		.maxlen		=3D sizeof(int),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dointvec_ms_jiffies,
> -	},
> -	{
> -		.procname	=3D "icmp_ratemask",
> -		.data		=3D &init_net.ipv4.sysctl_icmp_ratemask,
> -		.maxlen		=3D sizeof(int),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dointvec
> -	},
>  	{
>  		.procname	=3D "icmp_msgs_per_sec",
>  		.data		=3D &init_net.ipv4.sysctl_icmp_msgs_per_sec,
> @@ -774,13 +716,6 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.extra1		=3D SYSCTL_ZERO,
>  		.extra2		=3D SYSCTL_ONE,
>  	},
> -	{
> -		.procname	=3D "ip_dynaddr",
> -		.data		=3D &init_net.ipv4.sysctl_ip_dynaddr,
> -		.maxlen		=3D sizeof(u8),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dou8vec_minmax,
> -	},
>  	{
>  		.procname	=3D "ip_early_demux",
>  		.data		=3D &init_net.ipv4.sysctl_ip_early_demux,
> @@ -811,15 +746,6 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.extra1		=3D SYSCTL_ZERO,
>  		.extra2		=3D SYSCTL_ONE,
>  	},
> -	{
> -		.procname	=3D "ip_default_ttl",
> -		.data		=3D &init_net.ipv4.sysctl_ip_default_ttl,
> -		.maxlen		=3D sizeof(u8),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dou8vec_minmax,
> -		.extra1		=3D &ip_ttl_min,
> -		.extra2		=3D &ip_ttl_max,
> -	},
>  	{
>  		.procname	=3D "ip_local_port_range",
>  		.maxlen		=3D 0,
> @@ -841,36 +767,6 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_do_large_bitmap,
>  	},
> -	{
> -		.procname	=3D "ip_no_pmtu_disc",
> -		.data		=3D &init_net.ipv4.sysctl_ip_no_pmtu_disc,
> -		.maxlen		=3D sizeof(u8),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dou8vec_minmax,
> -	},
> -	{
> -		.procname	=3D "ip_forward_use_pmtu",
> -		.data		=3D &init_net.ipv4.sysctl_ip_fwd_use_pmtu,
> -		.maxlen		=3D sizeof(u8),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dou8vec_minmax,
> -	},
> -	{
> -		.procname	=3D "ip_forward_update_priority",
> -		.data		=3D &init_net.ipv4.sysctl_ip_fwd_update_priority,
> -		.maxlen		=3D sizeof(u8),
> -		.mode		=3D 0644,
> -		.proc_handler   =3D ipv4_fwd_update_priority,
> -		.extra1		=3D SYSCTL_ZERO,
> -		.extra2		=3D SYSCTL_ONE,
> -	},
> -	{
> -		.procname	=3D "ip_nonlocal_bind",
> -		.data		=3D &init_net.ipv4.sysctl_ip_nonlocal_bind,
> -		.maxlen		=3D sizeof(u8),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dou8vec_minmax,
> -	},
>  	{
>  		.procname	=3D "ip_autobind_reuse",
>  		.data		=3D &init_net.ipv4.sysctl_ip_autobind_reuse,
> @@ -880,13 +776,6 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.extra1         =3D SYSCTL_ZERO,
>  		.extra2         =3D SYSCTL_ONE,
>  	},
> -	{
> -		.procname	=3D "fwmark_reflect",
> -		.data		=3D &init_net.ipv4.sysctl_fwmark_reflect,
> -		.maxlen		=3D sizeof(u8),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dou8vec_minmax,
> -	},
>  	{
>  		.procname	=3D "tcp_fwmark_accept",
>  		.data		=3D &init_net.ipv4.sysctl_tcp_fwmark_accept,
> @@ -952,37 +841,6 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.proc_handler	=3D proc_douintvec_minmax,
>  		.extra2		=3D &u32_max_div_HZ,
>  	},
> -	{
> -		.procname	=3D "igmp_link_local_mcast_reports",
> -		.data		=3D &init_net.ipv4.sysctl_igmp_llm_reports,
> -		.maxlen		=3D sizeof(u8),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dou8vec_minmax,
> -	},
> -	{
> -		.procname	=3D "igmp_max_memberships",
> -		.data		=3D &init_net.ipv4.sysctl_igmp_max_memberships,
> -		.maxlen		=3D sizeof(int),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dointvec
> -	},
> -	{
> -		.procname	=3D "igmp_max_msf",
> -		.data		=3D &init_net.ipv4.sysctl_igmp_max_msf,
> -		.maxlen		=3D sizeof(int),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dointvec
> -	},
> -#ifdef CONFIG_IP_MULTICAST
> -	{
> -		.procname	=3D "igmp_qrv",
> -		.data		=3D &init_net.ipv4.sysctl_igmp_qrv,
> -		.maxlen		=3D sizeof(int),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dointvec_minmax,
> -		.extra1		=3D SYSCTL_ONE
> -	},
> -#endif
>  	{
>  		.procname	=3D "tcp_congestion_control",
>  		.data		=3D &init_net.ipv4.tcp_congestion_control,
> @@ -1154,42 +1012,6 @@ static const struct ctl_table ipv4_net_table[] =3D=
 {
>  		.proc_handler	=3D proc_tfo_blackhole_detect_timeout,
>  		.extra1		=3D SYSCTL_ZERO,
>  	},
> -#ifdef CONFIG_IP_ROUTE_MULTIPATH
> -	{
> -		.procname	=3D "fib_multipath_use_neigh",
> -		.data		=3D &init_net.ipv4.sysctl_fib_multipath_use_neigh,
> -		.maxlen		=3D sizeof(u8),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dou8vec_minmax,
> -		.extra1		=3D SYSCTL_ZERO,
> -		.extra2		=3D SYSCTL_ONE,
> -	},
> -	{
> -		.procname	=3D "fib_multipath_hash_policy",
> -		.data		=3D &init_net.ipv4.sysctl_fib_multipath_hash_policy,
> -		.maxlen		=3D sizeof(u8),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_fib_multipath_hash_policy,
> -		.extra1		=3D SYSCTL_ZERO,
> -		.extra2		=3D SYSCTL_THREE,
> -	},
> -	{
> -		.procname	=3D "fib_multipath_hash_fields",
> -		.data		=3D &init_net.ipv4.sysctl_fib_multipath_hash_fields,
> -		.maxlen		=3D sizeof(u32),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_fib_multipath_hash_fields,
> -		.extra1		=3D SYSCTL_ONE,
> -		.extra2		=3D &fib_multipath_hash_fields_all_mask,
> -	},
> -	{
> -		.procname	=3D "fib_multipath_hash_seed",
> -		.data		=3D &init_net,
> -		.maxlen		=3D sizeof(u32),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_fib_multipath_hash_seed,
> -	},
> -#endif
>  	{
>  		.procname	=3D "ip_unprivileged_port_start",
>  		.maxlen		=3D sizeof(int),
> @@ -1563,15 +1385,6 @@ static const struct ctl_table ipv4_net_table[] =3D=
 {
>  		.proc_handler	=3D proc_dointvec_minmax,
>  		.extra1		=3D SYSCTL_ONE
>  	},
> -	{
> -		.procname	=3D "fib_notify_on_flag_change",
> -		.data		=3D &init_net.ipv4.sysctl_fib_notify_on_flag_change,
> -		.maxlen		=3D sizeof(u8),
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dou8vec_minmax,
> -		.extra1		=3D SYSCTL_ZERO,
> -		.extra2		=3D SYSCTL_TWO,
> -	},
>  	{
>  		.procname       =3D "tcp_plb_enabled",
>  		.data           =3D &init_net.ipv4.sysctl_tcp_plb_enabled,
> @@ -1656,6 +1469,196 @@ static const struct ctl_table ipv4_net_table[] =
=3D {
>  		.extra1		=3D SYSCTL_ONE_THOUSAND,
>  		.extra2		=3D &tcp_rto_max_max,
>  	},
> +#if IS_ENABLED(CONFIG_IPV4)
> +	{
> +		.procname	=3D "icmp_echo_ignore_all",
> +		.data		=3D &init_net.ipv4.sysctl_icmp_echo_ignore_all,
> +		.maxlen		=3D sizeof(u8),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dou8vec_minmax,
> +		.extra1		=3D SYSCTL_ZERO,
> +		.extra2		=3D SYSCTL_ONE
> +	},
> +	{
> +		.procname	=3D "icmp_echo_ignore_broadcasts",
> +		.data		=3D &init_net.ipv4.sysctl_icmp_echo_ignore_broadcasts,
> +		.maxlen		=3D sizeof(u8),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dou8vec_minmax,
> +		.extra1		=3D SYSCTL_ZERO,
> +		.extra2		=3D SYSCTL_ONE
> +	},
> +	{
> +		.procname	=3D "icmp_ignore_bogus_error_responses",
> +		.data		=3D &init_net.ipv4.sysctl_icmp_ignore_bogus_error_responses,
> +		.maxlen		=3D sizeof(u8),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dou8vec_minmax,
> +		.extra1		=3D SYSCTL_ZERO,
> +		.extra2		=3D SYSCTL_ONE
> +	},
> +	{
> +		.procname	=3D "icmp_errors_use_inbound_ifaddr",
> +		.data		=3D &init_net.ipv4.sysctl_icmp_errors_use_inbound_ifaddr,
> +		.maxlen		=3D sizeof(u8),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dou8vec_minmax,
> +		.extra1		=3D SYSCTL_ZERO,
> +		.extra2		=3D SYSCTL_ONE
> +	},
> +	{
> +		.procname	=3D "icmp_errors_extension_mask",
> +		.data		=3D &init_net.ipv4.sysctl_icmp_errors_extension_mask,
> +		.maxlen		=3D sizeof(u8),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dou8vec_minmax,
> +		.extra1		=3D SYSCTL_ZERO,
> +		.extra2		=3D &icmp_errors_extension_mask_all,
> +	},
> +	{
> +		.procname	=3D "icmp_ratelimit",
> +		.data		=3D &init_net.ipv4.sysctl_icmp_ratelimit,
> +		.maxlen		=3D sizeof(int),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dointvec_ms_jiffies,
> +	},
> +	{
> +		.procname	=3D "icmp_ratemask",
> +		.data		=3D &init_net.ipv4.sysctl_icmp_ratemask,
> +		.maxlen		=3D sizeof(int),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dointvec
> +	},
> +	{
> +		.procname	=3D "ip_dynaddr",
> +		.data		=3D &init_net.ipv4.sysctl_ip_dynaddr,
> +		.maxlen		=3D sizeof(u8),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dou8vec_minmax,
> +	},
> +	{
> +		.procname	=3D "ip_default_ttl",
> +		.data		=3D &init_net.ipv4.sysctl_ip_default_ttl,
> +		.maxlen		=3D sizeof(u8),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dou8vec_minmax,
> +		.extra1		=3D &ip_ttl_min,
> +		.extra2		=3D &ip_ttl_max,
> +	},
> +	{
> +		.procname	=3D "ip_no_pmtu_disc",
> +		.data		=3D &init_net.ipv4.sysctl_ip_no_pmtu_disc,
> +		.maxlen		=3D sizeof(u8),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dou8vec_minmax,
> +	},
> +	{
> +		.procname	=3D "ip_forward_use_pmtu",
> +		.data		=3D &init_net.ipv4.sysctl_ip_fwd_use_pmtu,
> +		.maxlen		=3D sizeof(u8),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dou8vec_minmax,
> +	},
> +	{
> +		.procname	=3D "ip_forward_update_priority",
> +		.data		=3D &init_net.ipv4.sysctl_ip_fwd_update_priority,
> +		.maxlen		=3D sizeof(u8),
> +		.mode		=3D 0644,
> +		.proc_handler   =3D ipv4_fwd_update_priority,
> +		.extra1		=3D SYSCTL_ZERO,
> +		.extra2		=3D SYSCTL_ONE,
> +	},
> +	{
> +		.procname	=3D "ip_nonlocal_bind",
> +		.data		=3D &init_net.ipv4.sysctl_ip_nonlocal_bind,
> +		.maxlen		=3D sizeof(u8),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dou8vec_minmax,
> +	},
> +	{
> +		.procname	=3D "fwmark_reflect",
> +		.data		=3D &init_net.ipv4.sysctl_fwmark_reflect,
> +		.maxlen		=3D sizeof(u8),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dou8vec_minmax,
> +	},
> +	{
> +		.procname	=3D "igmp_link_local_mcast_reports",
> +		.data		=3D &init_net.ipv4.sysctl_igmp_llm_reports,
> +		.maxlen		=3D sizeof(u8),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dou8vec_minmax,
> +	},
> +	{
> +		.procname	=3D "igmp_max_memberships",
> +		.data		=3D &init_net.ipv4.sysctl_igmp_max_memberships,
> +		.maxlen		=3D sizeof(int),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dointvec
> +	},
> +	{
> +		.procname	=3D "igmp_max_msf",
> +		.data		=3D &init_net.ipv4.sysctl_igmp_max_msf,
> +		.maxlen		=3D sizeof(int),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dointvec
> +	},
> +#ifdef CONFIG_IP_MULTICAST
> +	{
> +		.procname	=3D "igmp_qrv",
> +		.data		=3D &init_net.ipv4.sysctl_igmp_qrv,
> +		.maxlen		=3D sizeof(int),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dointvec_minmax,
> +		.extra1		=3D SYSCTL_ONE
> +	},
> +#endif
> +#ifdef CONFIG_IP_ROUTE_MULTIPATH
> +	{
> +		.procname	=3D "fib_multipath_use_neigh",
> +		.data		=3D &init_net.ipv4.sysctl_fib_multipath_use_neigh,
> +		.maxlen		=3D sizeof(u8),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dou8vec_minmax,
> +		.extra1		=3D SYSCTL_ZERO,
> +		.extra2		=3D SYSCTL_ONE,
> +	},
> +	{
> +		.procname	=3D "fib_multipath_hash_policy",
> +		.data		=3D &init_net.ipv4.sysctl_fib_multipath_hash_policy,
> +		.maxlen		=3D sizeof(u8),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_fib_multipath_hash_policy,
> +		.extra1		=3D SYSCTL_ZERO,
> +		.extra2		=3D SYSCTL_THREE,
> +	},
> +	{
> +		.procname	=3D "fib_multipath_hash_fields",
> +		.data		=3D &init_net.ipv4.sysctl_fib_multipath_hash_fields,
> +		.maxlen		=3D sizeof(u32),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_fib_multipath_hash_fields,
> +		.extra1		=3D SYSCTL_ONE,
> +		.extra2		=3D &fib_multipath_hash_fields_all_mask,
> +	},
> +	{
> +		.procname	=3D "fib_multipath_hash_seed",
> +		.data		=3D &init_net,
> +		.maxlen		=3D sizeof(u32),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_fib_multipath_hash_seed,
> +	},
> +#endif
> +	{
> +		.procname	=3D "fib_notify_on_flag_change",
> +		.data		=3D &init_net.ipv4.sysctl_fib_notify_on_flag_change,
> +		.maxlen		=3D sizeof(u8),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dou8vec_minmax,
> +		.extra1		=3D SYSCTL_ZERO,
> +		.extra2		=3D SYSCTL_TWO,
> +	},
> +#endif
>  };
> =20
>  static const struct ctl_table *ipv4_net_table_dup(struct net *net)
> --=20
> 2.55.0
>=20

--7zrdf2x4soilcfnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmq7ZT0ACgkQupfNUreW
QU+bMAv9Ge+pflC8zGBpkmkLF3HQg5K2WNh8PMBI4aMLtBMMYyhny6MsuuENFpMa
6+W5rFmlngAAzK1D1ckm0AZSTh4VUlK/IrKdrdAn985iY6UKeuBtDYQX6fbUXY5A
cKfP8e27HUjPWOzuUvS1efFDBqiJzD8boZwctE17E+aSu8Ao4wqiLuyzLvrdAv1G
OZWDInRqZ/WxqwnVGVy7WQbBxQqA0joydHSQtf+nzvrL9OUR9fZ0JDefPOJPkVVQ
MVCBXJ26zBUvrYODPeIA/7eI0MW6zw4C5irCUQ2aBPk1nMOLJ879jp6tjUt5Ccl5
2EBT4KkaPfi8b1pXgPlC4NFEE0f1Qm7y94DmTipn3L46oXa6jNakmKzI845fh3Oz
qGNnX/0/OQRvzCPKV6r+EaNU82vNwoeQ6Afcg63AMjcOnn7Nx/oYvJtIwIJHCAqM
lnB8tn7nVw/w4VL4a0WV4gyXhdYkBS7mf1Qe4dlFZEGZQ1fUdAAVU6NDfjMbezHL
xk6SrA/f
=Y1vm
-----END PGP SIGNATURE-----

--7zrdf2x4soilcfnf--
